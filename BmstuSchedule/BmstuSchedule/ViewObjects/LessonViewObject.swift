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
    var day: Int

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
        self.day = networkObject.day
        
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

    func isStarted() -> Bool {
        let currentDate = Date()
        let timeZone = Double(TimeZone.current.secondsFromGMT())
        let day = Calendar.current.component(.weekdayOrdinal, from: currentDate.addingTimeInterval(timeZone))

        guard self.day == day else {
            return false
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let currentTime = dateFormatter.string(from: currentDate)
        let currentTimeInterval = TimeInterval.getTimeInterval(from: currentTime)

        return (TimeInterval.getTimeInterval(from: startTime) <= currentTimeInterval)
        && (TimeInterval.getTimeInterval(from: endTime) > currentTimeInterval)
    }

    func currentValue() -> Double {
        let currentDate = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let currentTime = dateFormatter.string(from: currentDate)
        let currentTimeInterval = TimeInterval.getTimeInterval(from: currentTime)
        
        return (currentTimeInterval - TimeInterval.getTimeInterval(from: startTime))
        / (TimeInterval.getTimeInterval(from: endTime) - TimeInterval.getTimeInterval(from: startTime))
    }

    func leftTime() -> String {
        let currentDate = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let currentTime = dateFormatter.string(from: currentDate)
        let currentTimeInterval = TimeInterval.getTimeInterval(from: currentTime)
        
        return (TimeInterval.getTimeInterval(from: endTime) - currentTimeInterval).stringHoursAndMinutes()
    }
}

extension LessonViewObject: Comparable {
    static func < (lhs: LessonViewObject, rhs: LessonViewObject) -> Bool {
        lhs.startTime < rhs.startTime
    }
}
