//
//  LessonView.swift
//  BmstuSchedule
//
//  Created by Всеволод on 26.09.2023.
//

import SwiftUI

struct LessonView: View {
    let lesson: LessonViewObject

    @State var isFullName = false
    @State var isStarted = false
    @State var currentValue: Double?
    @State var leftTime: String?
    
    let timer = Timer.publish(
        every: 1,
        on: .current,
        in: .common
    ).autoconnect()

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
            if isStarted {
                Gauge(value: currentValue ?? 0) {
                    Text("Осталось \(leftTime ?? "")")
                }.gaugeStyle(LinearTextInsideGaugeStyle())
            }
        }
        .onAppear(perform: {
            updateTime()
        })
        .onReceive(timer) { _ in
            updateTime()
        }
    }

    private func updateTime() {
        isStarted = lesson.isStarted()
        if isStarted {
            withAnimation(.easeOut) {
                currentValue = lesson.currentValue()
            }
            leftTime = lesson.leftTime()
        } else {
            currentValue = nil
            leftTime = nil
        }
    }
}
