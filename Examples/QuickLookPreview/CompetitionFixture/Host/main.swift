import AppKit
let app = NSApplication.shared
app.setActivationPolicy(.regular)
let window = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 500, height: 150), styleMask: [.titled, .closable], backing: .buffered, defer: false)
window.title = "Quick Look competition fixture (test only)"
let label = NSTextField(wrappingLabelWithString: "This app contains a test-only competing Markdown Quick Look extension. It exists to verify macOS provider selection with two installed providers.")
label.frame = NSRect(x: 20, y: 30, width: 460, height: 90)
window.contentView?.addSubview(label)
window.center()
window.makeKeyAndOrderFront(nil)
app.activate(ignoringOtherApps: true)
app.run()
