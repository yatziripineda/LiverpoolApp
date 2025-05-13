//
//  FeatureCardView.swift
//  LIVERPOOLApp
//
//  Created by Gustavo Isaac Lopez Nunez on 13/05/25.
//

import SwiftUI

struct FeatureCardView: View {
    let title: String
    let iconName: String
    var action: (() -> Void)? = nil

    var body: some View {
        Button(action: { action?() }) {
            VStack(spacing: 8) {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                Text(title)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
            }
            .padding()
            .frame(width: 140, height: 140)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
    }
}

#Preview {
    FeatureCardView(title: "Asistente de compras", iconName: "assistantIcon")
}
