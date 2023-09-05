import Combine
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

class ScheduleViewModel: ObservableObject {
    @Published var days = SortedArray<DayViewObject>()
    private var cancellable: AnyCancellable?
    private let service = FirebaseService()
    
    init() {
        fetchData()
    }

    private func fetchData() {
        cancellable = service.fetchData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { error in
                print(error)
            }, receiveValue: { documents in
                let dayNetworkObjects = documents.compactMap({ document -> DayNetworkObject? in
                    try? document.data(as: DayNetworkObject.self)
                })
                self.days = .init(items: dayNetworkObjects.map { .init(from: $0) })
            })
    }

    func getCurrentDayNumber() -> Int {
        let timeZone = Double(TimeZone.current.secondsFromGMT())
        let day = Calendar.current.component(.weekdayOrdinal, from: Date().addingTimeInterval(timeZone))
        return (day + 1) % 6
    }
}
