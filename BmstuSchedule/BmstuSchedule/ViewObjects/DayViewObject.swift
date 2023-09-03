import Foundation

struct DayViewObject {
    var day: Int
    var lessons: SortedArray<LessonViewObject>

    init(from networkObject: DayNetworkObject) {
        self.day = networkObject.day
        self.lessons = .init(items: networkObject.lessons.map { LessonViewObject(from: $0) })
    }
}

extension DayViewObject: Comparable {
    static func < (lhs: DayViewObject, rhs: DayViewObject) -> Bool {
        lhs.day < rhs.day
    }
    
    static func == (lhs: DayViewObject, rhs: DayViewObject) -> Bool {
        lhs.day == rhs.day && lhs.lessons.items == rhs.lessons.items
    }
}
