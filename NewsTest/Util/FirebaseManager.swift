//
//  FirebaseManager.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 16.02.2023.
//

import UIKit
import FirebaseAuth

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    let auth = Auth.auth()
    
    func signUp(email: String, password: String, completion: @escaping (() -> Void)) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error {
                AlertModel.shared.showOkActionAlert(title: "Error", message: error.localizedDescription)
            }
            completion()
        }
    }
    
    func login(email: String, password: String, completion: @escaping (() -> Void)) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error {
                AlertModel.shared.showOkActionAlert(title: "Error", message: error.localizedDescription)
            }
            completion()
        }
    }
}
