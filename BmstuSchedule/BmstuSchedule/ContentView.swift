import SwiftUI

struct ContentView: View {
    @StateObject var model = ScheduleViewModel()
    @State private var selectedIndex: Int = 0

    var body: some View {
        VStack {
            TabView(selection: $selectedIndex) {
                ForEach(model.days.items.indices, id: \.self) { index in
                    List {
                        ForEach(model.days.items[index].lessons.items) { lesson in
                            LessonView(lesson: lesson)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .padding(5)
                        )
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            TabBarView(
                tabbarItems: model.days.items.map { $0.getDayName() },
                selectedIndex: $selectedIndex
            )
                .padding(.horizontal)
        }
        .statusBarHidden(false)
        .onAppear {
            selectedIndex = model.getCurrentDayNumber()
        }
    }
}

struct TabBarView: View {
    var tabbarItems: [String]

    @Binding var selectedIndex: Int
    @Namespace private var menuItemTransition

    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tabbarItems.indices, id: \.self) { index in
                     
                        TabbarItem(
                            name: tabbarItems[index],
                            isActive: selectedIndex == index,
                            namespace: menuItemTransition
                        )
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    selectedIndex = index
                                }
                            }
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(25)
            .onChange(of: selectedIndex) { index in
                withAnimation {
                    scrollView.scrollTo(index, anchor: .center)
                }
            }
        }
    }
}

struct TabbarItem: View {
    var name: String
    var isActive: Bool = false
    let namespace: Namespace.ID
 
    var body: some View {
        if isActive {
            Text(name)
                .bold()
                .font(.subheadline)
                .padding(.horizontal)
                .padding(.vertical, 4)
                .foregroundColor(.white)
                .background(Capsule().foregroundColor(.blue))
                .matchedGeometryEffect(id: "highlightmenuitem", in: namespace)
        } else {
            Text(name)
                .bold()
                .font(.subheadline)
                .padding(.horizontal)
                .padding(.vertical, 4)
                .foregroundColor(.black)
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
