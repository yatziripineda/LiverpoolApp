//
//  Models.swift
//  LIVERPOOLApp
//
//  Created by Gustavo Isaac Lopez Nunez on 13/05/25.
//

import Foundation

// MARK: - Models

struct Product: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let price: String
    let oldPrice: String?
}

struct Wishlist: Identifiable {
    let id = UUID()
    let name: String
    let count: Int
}

struct Customer: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let categories: [String]
    let currentBag: [Product]
    let wishlists: [Wishlist]
    let suggestions: [Product]
}

// MARK: - Dummy Data

let demoProducts = [
    Product(name: "Base para cama Fabato de MDF", imageName: "bedFabato", price: "$3,399.00", oldPrice: "$4,999.00"),
    Product(name: "Cajonera Fabato de MDF", imageName: "cajoneraFabato", price: "$3,299.00", oldPrice: "$5,799.00"),
    Product(name: "Sofá moderno", imageName: "sofaPlaceholder", price: "$7,499.00", oldPrice: nil)
]

let demoCustomer = Customer(
    name: "Yatziri Pineda Cabrera",
    imageName: "userPlaceholder",
    categories: ["Videojuegos", "Hogar", "Accesorios", "Electrónica"],
    currentBag: [demoProducts[0]],
    wishlists: [Wishlist(name: "Mi Wishlist", count: 0)],
    suggestions: demoProducts
)
