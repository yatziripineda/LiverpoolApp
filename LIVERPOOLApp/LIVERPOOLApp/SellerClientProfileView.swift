//
//  SellerClientProfileView.swift
//  LIVERPOOLApp
//
//  Created by Gustavo Isaac Lopez Nunez on 13/05/25.
//

import SwiftUI

struct SellerClientProfileView: View {
    let customer: Customer

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                HStack {
                    Button(action: {}) { Image(systemName: "chevron.left") }
                    Spacer()
                }
                .foregroundColor(.white)
                .padding()
                .background( Color.pinkLiverpool )

                // Profile
                HStack(alignment: .top, spacing: 12) {
                    Image(customer.imageName)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    VStack(alignment: .leading, spacing: 4) {
                        Text(customer.name).font(.headline)
                        Text("¿Qué le gusta comprar?")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text(customer.categories.joined(separator: ", "))
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal)

                // Bolsa Actual
                Text("Bolsa Actual").font(.headline).padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(customer.currentBag) { prod in
                            VStack(alignment: .leading) {
                                Image(prod.imageName)
                                    .resizable()
                                    .frame(width: 120, height: 80)
                                    .cornerRadius(8)
                                Text(prod.name).font(.caption)
                            }
                            .frame(width: 120)
                        }
                    }
                    .padding(.horizontal)
                }

                // Wishlists
                Text("Wishlists Activas").font(.headline).padding(.horizontal)
                VStack {
                    ForEach(customer.wishlists) { list in
                        NavigationLink(destination: Text("Detalle de \(list.name)")) {
                            HStack {
                                Image(systemName: "gift.fill")
                                Text(list.name)
                                Spacer()
                                Text("\(list.count) artículos").font(.caption).foregroundColor(.gray)
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)

                // Sugerencias
                Text("Lo que le puede gustar").font(.headline).padding(.horizontal)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(customer.suggestions) { prod in
                            VStack(alignment: .leading) {
                                Image(prod.imageName)
                                    .resizable()
                                    .frame(width: 120, height: 80)
                                    .cornerRadius(8)
                                Text(prod.name).font(.caption)
                                Text(prod.price).font(.caption2).foregroundColor(.red)
                            }
                            .frame(width: 120)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    SellerClientProfileView(customer: demoCustomer)
}
