//
//  ClienteViewModel.swift
//  LIVERPOOLApp
//
//  Created by Gustavo Isaac Lopez Nunez on 13/05/25.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ClienteViewModel: ObservableObject {
  private let storage = Storage.storage().reference()
  private let db = Firestore.firestore()

  func uploadCustomer(name: String, image: UIImage, completion: @escaping (Bool)->Void) {
    guard let data = image.jpegData(compressionQuality: 0.8) else {
      completion(false); return
    }
    // crea un ID único
    let id = UUID().uuidString
    let path = "customer_images/\(id).jpg"
    storage.child(path).putData(data, metadata: nil) { _, error in
      guard error == nil else { completion(false); return }
      self.storage.child(path).downloadURL { url, error in
        guard let url = url else { completion(false); return }
        // guarda en Firestore
        let doc: [String: Any] = [
          "id": id,
          "name": name,
          "imageURL": url.absoluteString,
          "timestamp": FieldValue.serverTimestamp()
        ]
        self.db.collection("sharedCustomers").document(id).setData(doc) { err in
          completion(err == nil)
        }
      }
    }
  }
}
