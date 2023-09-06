import Foundation

struct LessonNetworkObject: Codable {
    var name: String
    var type: Int?
    var typeNumerator: Int?
    var typeDenominator: Int?
    var office: String?
    var teacher: String?
    var teacherName: String?
    var startTime: String
    var endTime: String
    var day: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case type
        case typeNumerator = "type_numerator"
        case typeDenominator = "type_denominator"
        case office
        case teacher
        case teacherName = "teacher_name"
        case startTime = "start_time"
        case endTime = "end_time"
        case day
    }
}
