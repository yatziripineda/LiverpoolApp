//
//  SellerClientsListView.swift
//  Liverpool-Seller
//
//  Created by Gustavo Isaac Lopez Nunez on 13/05/25.
//

import SwiftUI

struct SellerClientsListView: View {
    @StateObject private var vm = SellerViewModel()
    
    // Hardcodea tus departamentos aquí
    @State private var selectedDepartment = "Hogar"
    private let departments = [
        "Hogar", "Electrónica",
        "Videojuegos", "Zapatos",
        "Belleza"
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Título fijo
                HStack {
                    Text("Clientes")
                        .font(.largeTitle).bold()
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 8)

                // Tabs de departamentos
                DepartmentsHeaderView(
                    selectedDepartment: $selectedDepartment,
                    departments: departments
                )

                // Lista de clientes
                List(vm.customers) { cust in
                    NavigationLink {
                        SellerClientProfileView(customer: cust)
                    } label: {
                        HStack(spacing: 12) {
                            AsyncImage(url: URL(string: cust.imageURL)) { img in
                                img.resizable()
                            } placeholder: {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                            }
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())

                            VStack(alignment: .leading, spacing: 4) {
                                Text(cust.name)
                                    .font(.headline)
                                Text("Departamento: \(selectedDepartment)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
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
}

#Preview {
    SellerClientsListView()
}
