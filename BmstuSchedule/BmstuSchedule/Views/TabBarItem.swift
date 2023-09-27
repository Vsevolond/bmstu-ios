//
//  TabBarItem.swift
//  BmstuSchedule
//
//  Created by Всеволод on 26.09.2023.
//

import SwiftUI

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
                .foregroundColor(
                    light: .black,
                    dark: .white.opacity(0.5)
                )
        }
    }
}
