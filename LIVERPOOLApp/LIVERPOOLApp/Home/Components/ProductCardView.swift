//
//  ProductCardView.swift
//  LIVERPOOLApp
//
//  Created by Gustavo Isaac Lopez Nunez on 13/05/25.
//

import SwiftUI

struct ProductCardView: View {
    let name: String
    let imageName: String
    let price: String
    let oldPrice: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 100)
                .cornerRadius(8)
            Text(name)
                .font(.caption2)
                .lineLimit(2)
            HStack(spacing: 4) {
                Text(price)
                    .font(.caption).bold()
                    .foregroundColor(.red)
                if let old = oldPrice {
                    Text(old)
                        .font(.caption2)
                        .strikethrough()
                        .foregroundColor(.gray)
                }
            }
        }
        .frame(width: 160)
        .padding(.vertical, 8)
    }
}

#Preview {
    ProductCardView(
        name: "Set de almohada Tesso Home",
        imageName: "cushionImage",
        price: "$649.00",
        oldPrice: "$739.00"
    )
}
