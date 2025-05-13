//
//  NotificationPermissionView.swift
//  LIVERPOOLApp
//
//  Created by Gustavo Isaac Lopez Nunez on 13/05/25.
//

import SwiftUI

struct NotificationPermissionView: View {
    let onDecline: () -> Void
    let onAccept:  () -> Void
    @State private var termsAccepted = false

    var body: some View {
        VStack(spacing: 16) {
            Text("Cerca de Liverpool")
                .font(.title).bold()

            Text("¿Quieres sugerencias personalizadas de nuestros vendedores en tienda?")
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Image("storePlaceholder")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(12)
                .padding(.horizontal)

            Toggle("Acepto términos y condiciones", isOn: $termsAccepted)
                .font(.caption2)
                .padding(.horizontal)

            HStack(spacing: 16) {
                Button("No compartir") {
                    onDecline()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)

                Button("Compartir") {
                    onAccept()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(termsAccepted ? Color.pinkLiverpool : Color.pinkLiverpool.opacity(0.5))
                .foregroundColor(.white)
                .cornerRadius(8)
                .disabled(!termsAccepted)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.top, 40) // status bar
    }
}

#Preview {
    NotificationPermissionView(onDecline:{ print("Declina") }, onAccept:{ print("Aceptar") })
}
