//
//  Liverpool_SellerApp.swift
//  Liverpool-Seller
//
//  Created by Gustavo Isaac Lopez Nunez on 13/05/25.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        Auth.auth().signInAnonymously() { _, error in
            if let e = error { print("Auth error:", e) }
        }
        
        return true
    }
}

@main
struct Liverpool_SellerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            SellerClientsListView()
        }
    }
}
