//
//  Auth.swift
//
//
//  Created by Dorian on 03/11/2023.
//

import Foundation
import CryptoKit

enum AuthStringGenerator {
    static func auth(password: String, salt: String, challenge: String) -> String? {
        // secret (pw + salt)
        guard let saltedSecret = (password + salt).data(using: .utf8) else { return nil }
        let secret = Data(SHA256.hash(data: saltedSecret)).base64EncodedString()

        guard let challengeSecret = (secret + challenge).data(using: .utf8) else { return nil }
        return Data(SHA256.hash(data: challengeSecret)).base64EncodedString()
    }
}
