import Foundation

class Reidentify: Message<Reidentify.Payload> {

    init(events: Configuration.Events = .all) {
        super.init(op: .reidentify, data: .init(events: events))
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
    struct Payload: Codable {

        enum CodingKeys: String, CodingKey {
            case events = "eventSubscriptions"
        }

        let events: Configuration.Events
    }
}
