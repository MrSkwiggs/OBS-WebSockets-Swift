import Foundation

public extension Configuration {
    enum Authentication {
        case passwordless
        case password(String)
    }
}
