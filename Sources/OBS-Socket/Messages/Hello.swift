import Foundation

class Hello: Message<Hello.Payload> {
    struct Payload: Codable {
        let obsWebSocketVersion: String
        let rpcVersion: Int
        let auth: AuthData?

        struct AuthData: Codable {
            let challenge: String
            let salt: String

            enum CodingKeys: String, CodingKey {
                case challenge = "challenge"
                case salt = "salt"
            }
        }

        private enum CodingKeys: String, CodingKey {
            case obsWebSocketVersion = "obsWebSocketVersion"
            case rpcVersion = "rpcVersion"
            case auth = "authentication"
        }
    }
}
