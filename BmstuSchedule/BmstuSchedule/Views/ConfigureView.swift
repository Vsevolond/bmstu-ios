//
//  ConfigureView.swift
//  BmstuSchedule
//
//  Created by Всеволод on 26.09.2023.
//

import SwiftUI

struct ConfigureView: View {
    
    enum ConfigureType {
        
        case create
        case edit
    }
    
    var configureType: ConfigureType
    
    @State var selectedDay: DayName
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()
    @State private var name: String = ""
    @State private var type: LessonType = .lecture
    @State private var teacher: String = ""
    @State private var place: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("День", selection: $selectedDay) {
                        ForEach(DayName.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    DatePicker("Начало", selection: $startTime, displayedComponents: .hourAndMinute)
                    DatePicker("Конец", selection: $endTime, displayedComponents: .hourAndMinute)
                }
                
                Section {
                    TextField("Название", text: $name)
                    Picker("Тип", selection: $type) {
                        ForEach(LessonType.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                }
                
                Section {
                    TextField("Преподаватель", text: $teacher)
                    TextField("Кабинет", text: $place)
                }
            }
            .navigationTitle(configureType == .create ? "Создание" : "Изменение")
            
            Button {
                print("approve")
            } label: {
                Text(configureType == .create ? "Создать" : "Изменить")
                    .bold()
                    .foregroundColor(light: .black, dark: .white)
                    .padding(10)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}

#Preview {
    ConfigureView(configureType: .create, selectedDay: .tuesday)
}
