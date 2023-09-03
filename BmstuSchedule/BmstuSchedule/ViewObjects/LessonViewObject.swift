import Foundation

struct LessonViewObject {
    var name: String
    var type: String
    var office: String
    var teacher: String
    var teacherName: String
    var startTime: TimeInterval
    var endTime: TimeInterval
    
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
        self.startTime = .getTimeInterval(from: networkObject.startTime)
        self.endTime = .getTimeInterval(from: networkObject.endTime)
        
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
}

extension LessonViewObject: Comparable {
    static func < (lhs: LessonViewObject, rhs: LessonViewObject) -> Bool {
        lhs.startTime < rhs.startTime
    }
}
