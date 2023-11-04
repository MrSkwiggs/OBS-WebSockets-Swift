import Foundation

public struct Configuration {
    public let url: URL
    public let auth: Authentication
    public let events: Events
    public let rpcVersion: Int

    public init(
        url: URL,
        password: String?,
        events: Events = .all,
        rpcVersion: Int = 1
    ) {
        self.url = url
        self.auth = password.map { .password($0) } ?? .passwordless
        self.events = events
        self.rpcVersion = rpcVersion
    }
}
