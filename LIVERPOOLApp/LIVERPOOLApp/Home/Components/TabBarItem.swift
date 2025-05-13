//
//  TabBarItem.swift
//  LIVERPOOLApp
//
//  Created by Gustavo Isaac Lopez Nunez on 13/05/25.
//

import SwiftUI

struct TabBarItem: View {
    let icon: String
    let title: String
    var isSelected: Bool = false

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(isSelected ? .pinkLiverpool : .gray)
            Text(title)
                .font(.caption2)
                .foregroundColor(isSelected ? .pinkLiverpool : .gray)
        }
    }
}

#Preview {
    TabBarItem(icon: "house.fill", title: "Inicio", isSelected: true)
}
