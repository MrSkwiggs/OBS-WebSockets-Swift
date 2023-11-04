import Foundation

class Message<Payload: Codable>: Codable {
    let op: OpCode
    let data: Payload

    init(op: OpCode, data: Payload) {
        self.op = op
        self.data = data
    }

    enum CodingKeys: String, CodingKey {
        case op = "op"
        case data = "d"
    }
}
