//
//  ContentView.swift
//  BmstuSchedule
//
//  Created by Всеволод on 02.09.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = ScheduleViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
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
