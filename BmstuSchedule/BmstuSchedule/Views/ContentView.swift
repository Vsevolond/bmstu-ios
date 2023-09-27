import SwiftUI

struct ContentView: View {
    @StateObject private var model = ScheduleViewModel()
    @State private var selectedIndex: Int = 0
    @State private var alertPresented: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                LessonsTabView(
                    model: model,
                    selectedIndex: $selectedIndex,
                    alertPresented: $alertPresented
                )

                TabBarView(
                    tabbarItems: model.days.items.map { $0.getDayName() },
                    selectedIndex: $selectedIndex
                )
                .padding(.horizontal)
            }
            .statusBarHidden(false)
            .navigationTitle("Расписание")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32, alignment: .center)
                    })
                    .background {
                        NavigationLink {
                            ConfigureView(configureType: .create, selectedDay: DayName.allCases[selectedIndex])
                        } label: {
                            EmptyView()
                        }

                    }
                }
            }
        }
    }
}

struct LessonsTabView: View {
    @ObservedObject var model: ScheduleViewModel
    @Binding var selectedIndex: Int
    @Binding var alertPresented: Bool
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(model.days.items.indices, id: \.self) { index in
                List {
                    ForEach(model.days.items[index].lessons.items) { lesson in
                        LessonView(lesson: lesson)
                            .contextMenu(menuItems: {
                                Button {
                                    alertPresented = true
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                
                                Button(action: {}) {
                                    Label("Edit", systemImage: "pencil.line")
                                }
                                .background {
                                    NavigationLink {
                                        ConfigureView(configureType: .edit, selectedDay: DayName.allCases[selectedIndex])
                                    } label: {
                                        EmptyView()
                                    }

                                }
                            })
                            .alert("Are you sure?", isPresented: $alertPresented) {
                                Button("Delete", role: .destructive) {
                                    
                                }
                                Button("Cancel", role: .cancel) {}
                            }
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(
                                light: .white,
                                dark: .gray.opacity(0.2)
                            )
                            .padding(5)
                    )
                }
            }
            .onAppear {
                selectedIndex = model.getCurrentDayNumber()
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
