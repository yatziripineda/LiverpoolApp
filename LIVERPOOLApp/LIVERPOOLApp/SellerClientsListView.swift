//
//  SellerClientsListView.swift
//  LIVERPOOLApp
//
//  Created by Gustavo Isaac Lopez Nunez on 13/05/25.
//

import SwiftUI

struct SellerClientsListView: View {
    let department = "Departamento de Hogar"
    let customers = [demoCustomer]

    var body: some View {
        VStack(alignment: .leading) {
            // Header
            HStack {
                Button(action: {}) { Image(systemName: "chevron.left") }
                Spacer()
                Text("Clientes").font(.headline)
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
            .background( Color.pinkLiverpool )

            Text(department)
                .font(.subheadline)
                .padding(.horizontal)

            List(customers) { cust in
                NavigationLink(destination: SellerClientProfileView(customer: cust)) {
                    HStack {
                        Image(cust.imageName)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text(cust.name)
                            Text("\(cust.currentBag.count) artículos en su bolsa")
                                .font(.caption).foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 4)
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    SellerClientsListView()
}
