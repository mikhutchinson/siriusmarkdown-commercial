import AppKit
import Quartz
import OSLog

/// Controlled test competitor. No dependency on the production renderer.
final class PreviewViewController: NSViewController, @preconcurrency QLPreviewingController {
    override func loadView() {
        let root = NSView(frame: NSRect(x: 0, y: 0, width: 700, height: 500))
        let label = NSTextField(wrappingLabelWithString: "COMPETING MARKDOWN PREVIEW\n\nControlled test fixture selected by macOS.\nThis is not SiriusMarkdown.")
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .systemOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        root.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: root.leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: root.trailingAnchor, constant: -40),
            label.centerYAnchor.constraint(equalTo: root.centerYAnchor)
        ])
        view = root
    }
    func preparePreviewOfFile(at url: URL, completionHandler handler: @escaping (Error?) -> Void) {
        Logger(subsystem: "dev.swiftpython.SiriusMarkdownCompetitionFixture", category: "Preview")
            .notice("competition_fixture_selected file=\(url.lastPathComponent, privacy: .public)")
        handler(nil)
    }
}
