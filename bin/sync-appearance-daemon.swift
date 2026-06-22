import Foundation

let center = DistributedNotificationCenter.default()
center.addObserver(
    forName: Notification.Name("AppleInterfaceThemeChangedNotification"),
    object: nil,
    queue: nil
) { _ in
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    process.arguments = ["zsh", "-c", "/Users/davidask/.dotfiles/bin/sync-appearance"]
    try? process.run()
}

RunLoop.main.run()
