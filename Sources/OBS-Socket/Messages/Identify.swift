import Foundation

class Identify: Message<Identify.Payload> {
    init(authentication: String, config: Configuration) {
        super.init(op: .identify, data: .init(authentication: authentication, events: config.events, rpcVersion: config.rpcVersion))
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    struct Payload: Codable {
        let authentication: String
        let events: Configuration.Events
        let rpcVersion: Int

        init(
            authentication: String,
            events: Configuration.Events,
            rpcVersion: Int
        ) {
            self.authentication = authentication
            self.events = events
            self.rpcVersion = rpcVersion
        }

        enum CodingKeys: String, CodingKey {
            case rpcVersion = "rpcVersion"
            case authentication = "authentication"
            case events = "eventSubscriptions"
        }
    }
}
