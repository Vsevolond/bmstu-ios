import SwiftUI

struct ContentView: View {
    @StateObject var model = ScheduleViewModel()
    
    var body: some View {
        TabView {
            ForEach(model.days.items) { day in
                List(day.lessons.items) { lesson in
                    Text(lesson.name)
                        .bold()
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .onAppear {
            model.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
