import Foundation

struct DayViewObject: Identifiable {
    var id = UUID()
    var day: Int
    var lessons: SortedArray<LessonViewObject>

    init(from networkObject: DayNetworkObject) {
        self.day = networkObject.day
        self.lessons = .init(items: networkObject.lessons.map { LessonViewObject(from: $0) })
    }

    private enum DayName: String, CaseIterable {
        case monday = "Понедельник"
        case tuesday = "Вторник"
        case wednesday = "Среда"
        case thursday = "Четверг"
        case friday = "Пятница"
        case saturday = "Суббота"
    }

    func getDayName() -> String {
        DayName.allCases[day].rawValue
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
