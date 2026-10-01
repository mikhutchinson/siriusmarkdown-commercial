import AppKit
import Quartz
import OSLog

/// This app deliberately uses only Apple's QLPreviewView. It does not instantiate
/// SiriusMarkdown, so seeing formatted output here exercises system routing.
@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    private var window: NSWindow!
    private var preview: QLPreviewView?
    private var files: [URL] = []
    private var index = 0
    private var timer: Timer?
    private var remaining = 0
    private let status = NSTextField(labelWithString: "Open a Markdown file to test the system-selected preview provider.")
    private let logger = Logger(subsystem: "dev.swiftpython.SiriusMarkdownPreview", category: "QLPreviewViewHost")
    private var evidenceURL: URL?
    private var started = ProcessInfo.processInfo.systemUptime
    private var lastTick = ProcessInfo.processInfo.systemUptime
    private var maxTickGap = 0.0
    private var pulse: Timer?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let arguments = CommandLine.arguments.dropFirst()
        evidenceURL = arguments.first(where: { $0.hasPrefix("--evidence=") })
            .map { URL(fileURLWithPath: String($0.dropFirst("--evidence=".count))) }
        files = arguments.filter { !$0.hasPrefix("-") }.map { URL(fileURLWithPath: $0) }
        window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 1050, height: 820),
                          styleMask: [.titled, .closable, .miniaturizable, .resizable], backing: .buffered, defer: false)
        window.title = "SiriusMarkdown · Actual QLPreviewView host"
        window.delegate = self
        window.isReleasedWhenClosed = false
        let root = NSView()
        window.contentView = root
        let controls = NSStackView()
        controls.orientation = .horizontal
        controls.spacing = 8
        for (label, action) in [("Open…", #selector(openFile)), ("Previous", #selector(previous)),
                                 ("Next", #selector(next)), ("Close / Reopen", #selector(reopen)),
                                 ("Stress 100", #selector(stress)), ("Appearance", #selector(appearance))] {
            controls.addArrangedSubview(NSButton(title: label, target: self, action: action))
        }
        status.font = .systemFont(ofSize: 11)
        status.lineBreakMode = .byTruncatingMiddle
        for view in [controls, status] {
            view.translatesAutoresizingMaskIntoConstraints = false
            root.addSubview(view)
        }
        NSLayoutConstraint.activate([
            controls.topAnchor.constraint(equalTo: root.topAnchor, constant: 10),
            controls.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 12),
            status.topAnchor.constraint(equalTo: controls.bottomAnchor, constant: 8),
            status.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 12),
            status.trailingAnchor.constraint(equalTo: root.trailingAnchor, constant: -12)
        ])
        installPreview()
        buildMenu()
        window.center()
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        record("host_started", extra: ["files": files.count])
        pulse = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            MainActor.assumeIsolated {
                guard let self else { return }
                let now = ProcessInfo.processInfo.systemUptime
                self.maxTickGap = max(self.maxTickGap, now - self.lastTick)
                self.lastTick = now
            }
        }
        if !files.isEmpty { showFile() }
        if let value = arguments.first(where: { $0.hasPrefix("--stress=") }),
           let count = Int(value.dropFirst("--stress=".count)) {
            let interval = arguments.first(where: { $0.hasPrefix("--interval=") })
                .flatMap { Double($0.dropFirst("--interval=".count)) } ?? 0.15
            runStress(count: count, interval: interval)
        }
    }

    private func installPreview() {
        guard let root = window.contentView else { return }
        let view = QLPreviewView(frame: .zero, style: .normal)!
        view.shouldCloseWithWindow = false
        view.autostarts = false
        view.translatesAutoresizingMaskIntoConstraints = false
        root.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: status.bottomAnchor, constant: 8),
            view.leadingAnchor.constraint(equalTo: root.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: root.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: root.bottomAnchor)
        ])
        preview = view
    }

    private func showFile() {
        guard !files.isEmpty else { return }
        index = (index + files.count) % files.count
        let url = files[index]
        status.stringValue = "\(index + 1)/\(files.count) · \(url.path) · provider selected by macOS"
        preview?.previewItem = url as NSURL
        record("preview_item_assigned", extra: ["path": url.path, "index": index])
    }

    @objc private func openFile() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = true
        if panel.runModal() == .OK { files = panel.urls; index = 0; showFile() }
    }
    @objc private func next() { index += 1; showFile() }
    @objc private func previous() { index -= 1; showFile() }
    @objc private func reopen() {
        preview?.close()
        preview?.removeFromSuperview()
        preview = nil
        record("preview_closed")
        installPreview()
        showFile()
    }
    @objc private func appearance() {
        window.appearance = window.effectiveAppearance.bestMatch(from: [.aqua, .darkAqua]) == .darkAqua
            ? NSAppearance(named: .aqua) : NSAppearance(named: .darkAqua)
        record("appearance_changed", extra: ["appearance": window.appearance?.name.rawValue ?? "system"])
    }
    @objc private func stress() { runStress(count: 100, interval: 0.15) }
    private func runStress(count: Int, interval: Double) {
        guard !files.isEmpty, count > 0 else { return }
        timer?.invalidate()
        remaining = min(count, 10_000)
        maxTickGap = 0
        record("stress_started", extra: ["count": remaining, "interval": max(0.02, interval)])
        timer = Timer.scheduledTimer(timeInterval: max(0.02, interval), target: self,
                                     selector: #selector(stressStep), userInfo: nil, repeats: true)
    }
    @objc private func stressStep() {
        index += 1
        if remaining % 3 == 0 { reopen() } else { showFile() }
        remaining -= 1
        if remaining == 0 {
            timer?.invalidate()
            record("stress_finished", extra: ["host_max_heartbeat_gap_ms": maxTickGap * 1000])
        }
    }
    private func record(_ event: String, extra: [String: Any] = [:]) {
        var entry = extra
        entry["event"] = event
        entry["elapsed_seconds"] = ProcessInfo.processInfo.systemUptime - started
        entry["pid"] = ProcessInfo.processInfo.processIdentifier
        guard let data = try? JSONSerialization.data(withJSONObject: entry, options: [.sortedKeys]),
              let line = String(data: data, encoding: .utf8) else { return }
        logger.notice("\(line, privacy: .public)")
        guard let evidenceURL else { return }
        if !FileManager.default.fileExists(atPath: evidenceURL.path) { FileManager.default.createFile(atPath: evidenceURL.path, contents: nil) }
        if let handle = try? FileHandle(forWritingTo: evidenceURL) {
            defer { try? handle.close() }
            _ = try? handle.seekToEnd()
            try? handle.write(contentsOf: Data((line + "\n").utf8))
        }
    }
    private func buildMenu() {
        let menu = NSMenu()
        let appMenu = NSMenu()
        appMenu.addItem(withTitle: "Quit SiriusMarkdown Preview", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        let appItem = NSMenuItem(); appItem.submenu = appMenu; menu.addItem(appItem)
        let edit = NSMenu(title: "Edit")
        edit.addItem(withTitle: "Copy", action: #selector(NSText.copy(_:)), keyEquivalent: "c")
        edit.addItem(withTitle: "Select All", action: #selector(NSText.selectAll(_:)), keyEquivalent: "a")
        let editItem = NSMenuItem(); editItem.submenu = edit; menu.addItem(editItem)
        NSApp.mainMenu = menu
    }
    func application(_ sender: NSApplication, openFiles filenames: [String]) {
        files = filenames.map { URL(fileURLWithPath: $0) }; index = 0
        if window != nil { showFile() }
        sender.reply(toOpenOrPrint: .success)
    }
    func windowWillClose(_ notification: Notification) {
        timer?.invalidate(); pulse?.invalidate(); preview?.close(); preview = nil
        record("window_closed", extra: ["host_max_heartbeat_gap_ms": maxTickGap * 1000])
    }
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { true }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.setActivationPolicy(.regular)
app.run()
