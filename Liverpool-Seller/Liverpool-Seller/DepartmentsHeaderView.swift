//
//  DepartmentsHeaderView.swift
//  Liverpool-Seller
//
//  Created by Gustavo Isaac Lopez Nunez on 13/05/25.
//


import SwiftUI

struct DepartmentsHeaderView: View {
    @Binding var selectedDepartment: String
    let departments: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(departments, id: \.self) { dept in
                    Text(dept)
                        .font(.subheadline).bold()
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            selectedDepartment == dept
                                ? Color.pinkLiverpool
                                : Color.gray.opacity(0.2)
                        )
                        .foregroundColor(
                            selectedDepartment == dept
                                ? .white
                                : .gray
                        )
                        .cornerRadius(16)
                        .onTapGesture { selectedDepartment = dept }
                }
            }
            .padding(.horizontal)
        }
        .padding(.top)
    }
}
