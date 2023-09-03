import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ScheduleViewModel: ObservableObject {
    @Published var days = SortedArray<DayViewObject>()
    private let collection = "IU9-52B"

    private var db = Firestore.firestore()

    func fetchData() {
        db.collection(collection).addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents else {
                print("No documents")
                return
            }

            let dayNetworkObjects = documents.compactMap({ document -> DayNetworkObject? in
                return try? document.data(as: DayNetworkObject.self)
            })
            self.days = .init(items: dayNetworkObjects.map { .init(from: $0) })
        }
    }
}
