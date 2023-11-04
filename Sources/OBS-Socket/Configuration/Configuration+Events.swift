import Foundation

public extension Configuration {
    struct Events: OptionSet, Codable {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        public static let none = Events([])
        public static let  general = Events(rawValue: 1 << 0)
        public static let  config = Events(rawValue: 1 << 1)
        public static let  scenes = Events(rawValue: 1 << 2)
        public static let  inputs = Events(rawValue: 1 << 3)
        public static let  transitions = Events(rawValue: 1 << 4)
        public static let  filters = Events(rawValue: 1 << 5)
        public static let  outputs = Events(rawValue: 1 << 6)
        public static let  sceneItems = Events(rawValue: 1 << 7)
        public static let  mediaInputs = Events(rawValue: 1 << 8)
        public static let  vendors = Events(rawValue: 1 << 9)
        public static let  ui = Events(rawValue: 1 << 10)

        // MARK: High-Volume events
        public static let  inputVolumeMeters = Events(rawValue: 1 << 16)
        public static let  inputActiveStateChanged = Events(rawValue: 1 << 17)
        public static let  inputShowStateChanged = Events(rawValue: 1 << 18)
        public static let  sceneItemTransformChanged = Events(rawValue: 1 << 19)


        public static let  all: Events = [.general, .config, .scenes, .inputs, .transitions, .filters, .outputs, .sceneItems, .mediaInputs, .vendors, .ui]
    }
}
