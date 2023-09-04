import Foundation

struct LessonViewObject: Identifiable {
    var id = UUID()
    var name: String
    var type: String
    var office: String
    var teacher: String
    var teacherName: String
    var startTime: String
    var endTime: String

    enum LessonType: String, CaseIterable {
        case lecture = "Лекция"
        case seminar = "Семинар"
        case laboratory = "Лабораторная"
    }

    init(from networkObject: LessonNetworkObject) {
        self.name = networkObject.name
        self.office = networkObject.office ?? ""
        self.teacher = networkObject.teacher ?? ""
        self.teacherName = networkObject.teacherName ?? ""
        self.startTime = networkObject.startTime
        self.endTime = networkObject.endTime
        
        if let typeNumber = networkObject.type {
            self.type = LessonType.allCases[typeNumber].rawValue
        } else {
            guard
                let typeNumerator = networkObject.typeNumerator,
                let typeDenominator = networkObject.typeDenominator
            else {
                self.type = ""
                return
            }
            
            let currentWeek = Calendar.current.component(.weekOfYear, from: Date())
            if currentWeek % 2 == 0 {
                self.type = LessonType.allCases[typeDenominator].rawValue
            } else {
                self.type = LessonType.allCases[typeNumerator].rawValue
            }
        }
    }

    func startTimeInterval() -> TimeInterval {
        .getTimeInterval(from: startTime)
    }

    func endTimeInterval() -> TimeInterval {
        .getTimeInterval(from: endTime)
    }
}

extension LessonViewObject: Comparable {
    static func < (lhs: LessonViewObject, rhs: LessonViewObject) -> Bool {
        lhs.startTime < rhs.startTime
    }
}
