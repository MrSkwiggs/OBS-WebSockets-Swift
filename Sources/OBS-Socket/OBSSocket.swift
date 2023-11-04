import Foundation
import Combine

actor OBSSocket {
    private var stream: SocketStream

    private let encoder: JSONEncoder = .init()
    private let decoder: JSONDecoder = .init()

    let eventPublisher: PassthroughSubject<String, Never> = .init()

    var messageTask: Task<Void, Error>?

    init(config: Configuration) async throws {
        let session: URLSession = .init(configuration: .ephemeral)
        stream = .init(task: session.webSocketTask(with: config.url))

        try await handleAuthentication(with: config)

        messageTask = Task {
            do {
                for try await message in self
                    .stream
                    .compactMap({ message in
                        switch message {
                        case let .string(text): return text

                        case .data: fallthrough
                        @unknown default: return nil
                        }
                    })
                        .compactMap({ [weak self] text -> (op: OpCode, text: String, data: Data)? in
                            guard let self else { return nil }
                            struct None: Codable {}
                            let data = text.data(using: .utf8)!
                            let op = try decoder.decode(Message<None>.self, from: data).op
                            return (op: op, text: text, data: data)
                        })
                {
                    switch message.op {
                    case .hello:
                        break
                    case .identify:
                        break
                    case .identified:
                        print("Identified \(message.text)")
                    case .reidentify:
                        print("Reidentify \(message.text)")
                    case .request:
                        print("Request \(message.text)")
                    case .requestResponse:
                        print("Response \(message.text)")
                    case .requestBatch:
                        print("Request Batch \(message.text)")
                    case .requestBatchResponse:
                        print("Response Batch \(message.text)")
                    case .event:
                        print("Event \(message.text)")
                    }
                }
            } catch {
                print("Caught error: \(error)")
            }
        }
    }

    private func handleAuthentication(with config: Configuration) async throws {
        guard case let .string(hello) =  try await stream.task.receive() else {
            fatalError()
        }

        switch config.auth {
        case .passwordless:
            break;
        case .password(let password):
            guard let data = hello.data(using: .utf8) else { fatalError() }
            let message = try decoder.decode(Hello.self, from: data)

            guard let auth = message.data.auth else { break }

            guard let authentication = AuthStringGenerator.auth(password: password, salt: auth.salt, challenge: auth.challenge) else { fatalError() }
            try await send(message: Identify(authentication: authentication, config: config))
            guard case let .string(text) = try await stream.task.receive(),
                  let data = text.data(using: .utf8) else {
                fatalError()
            }
            let identified = try decoder.decode(Identified.self, from: data)
            guard identified.data.negotiatedRpcVersion == config.rpcVersion else {
                print("invalid RPC version: \(identified.data.negotiatedRpcVersion), expected \(config.rpcVersion)")
                fatalError()
            }
        }
        print("Socket identified, ready.")
    }

    func reidentify(with events: Configuration.Events = .all) async throws {
        try await send(message: Reidentify(events: events))
    }

    private func send<T: Codable>(message: T) async throws {
        guard let string = String(data: try encoder.encode(message), encoding: .utf8) else {
            fatalError()
        }
        try await stream.send(message: string)
    }
}

extension OBSSocket {
    
}
