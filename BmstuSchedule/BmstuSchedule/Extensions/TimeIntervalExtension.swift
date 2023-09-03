import Foundation

extension TimeInterval {

    static var secondsPerHour: Double { return 60 * 60 }
    static var secondsPerMinute: Double { return 60 }

    static func hours(_ value: Int) -> TimeInterval {
        return Double(value) * secondsPerHour
    }

    static func minutes(_ value: Int) -> TimeInterval {
        return Double(value) * secondsPerMinute
    }

    static func getTimeInterval(from string: String) -> TimeInterval {
        let components = string.split(separator: ":").compactMap { Int($0) }
        let hours = components[0]
        let minutes = components[1]
        return .hours(hours) + .minutes(minutes)
    }
}
