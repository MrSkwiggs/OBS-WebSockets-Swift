import Foundation

class Identified: Message<Identified.Payload> {
    struct Payload: Codable, Sendable {
        let negotiatedRpcVersion: Int

        enum CodingKeys: String, CodingKey {
            case negotiatedRpcVersion = "negotiatedRpcVersion"
        }
    }
}
