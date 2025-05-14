//
//  SellerViewModel.swift
//  Liverpool-Seller
//
//  Created by Gustavo Isaac Lopez Nunez on 13/05/25.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class SellerViewModel: ObservableObject {
  @Published var customers: [CustomerShared] = []
  private var listener: ListenerRegistration?

  init() {
    let db = Firestore.firestore()
    listener = db.collection("sharedCustomers")
      .order(by: "timestamp", descending: true)
      .addSnapshotListener { snap, error in
        guard let docs = snap?.documents else { return }
        self.customers = docs.compactMap { d in
          let data = d.data()
          guard let name = data["name"] as? String,
                let url = data["imageURL"] as? String else { return nil }
          return CustomerShared(id: d.documentID, name: name, imageURL: url)
        }
      }
  }
  deinit { listener?.remove() }
}

struct CustomerShared: Identifiable {
  let id: String
  let name: String
  let imageURL: String
}
