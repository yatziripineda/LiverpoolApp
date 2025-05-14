//
//  SellerClientProfileView.swift
//  Liverpool-Seller
//
//  Created by Gustavo Isaac Lopez Nunez on 13/05/25.
//

import SwiftUI

struct SellerClientProfileView: View {
    let customer: CustomerShared

    var body: some View {
        VStack(spacing: 16) {
            // Imagen grande
            AsyncImage(url: URL(string: customer.imageURL)) { img in
                img
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(height: 240)
            .clipped()
            .cornerRadius(12)

            // Nombre
            Text(customer.name)
                .font(.title2).bold()

            // Aquí podrías mostrar más campos si los guardas en Firestore
            Spacer()
        }
        .padding()
        .navigationTitle("Perfil")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SellerClientProfileView(
            customer: .init(
                id: "1",
                name: "Cliente de Prueba",
                imageURL: "https://via.placeholder.com/200"
            )
        )
}
