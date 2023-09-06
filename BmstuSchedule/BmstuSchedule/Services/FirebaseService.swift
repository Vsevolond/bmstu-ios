import Combine
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

class FirebaseService {
    private let collection = "IU9-52B"
    private var db = Firestore.firestore()
    
    func fetchData() -> AnyPublisher<[QueryDocumentSnapshot], any Error> {
        db.collection(collection).snapshotPublisher()
            .map(\.documents)
            .eraseToAnyPublisher()
    }
}
