import Foundation
import FirebaseFirestoreSwift

struct DayNetworkObject: Identifiable, Codable {
    @DocumentID var id: String?
    var day: Int
    var lessons: [LessonNetworkObject]
}
