import SwiftUI

struct ContentView: View {
    @StateObject var model = ScheduleViewModel()
    @State var isFullName = false
    
    var body: some View {
        TabView {
            ForEach(model.days.items) { day in
                List {
                    ForEach(day.lessons.items) { lesson in
                        LessonView(lesson: lesson)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .padding(5)
                    )
                }
//                .tabItem {
//                    Text("\(day.day)")
//                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .onAppear {
            model.fetchData()
        }
    }
}

struct LessonView: View {
    let lesson: LessonViewObject
    @State var isFullName = false

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(.gray)
                        VStack {
                            Text(lesson.startTime)
                                .foregroundColor(.blue)
                            Text(lesson.endTime)
                                .foregroundColor(.blue)
                        }
                    }
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.gray)
                        Text(lesson.office)
                            .foregroundColor(.blue)
                    }
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(lesson.name)
                        .bold()
                        .multilineTextAlignment(.trailing)
                    Text(lesson.type)
                        .foregroundColor(.gray)
                    Button(isFullName ? lesson.teacherName : lesson.teacher) {
                        withAnimation {
                            isFullName.toggle()
                        }
                    }
                }
            }
            Gauge(value: 0.5) {
                Text("Осталось 1ч 15м")
            }.gaugeStyle(LinearTextInsideGaugeStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
