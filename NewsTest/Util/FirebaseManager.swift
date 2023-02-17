//
//  FirebaseManager.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 16.02.2023.
//

import FirebaseAuth

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    var user: User?
    
    private var isLoggedIn = false
    
    let auth = Auth.auth()
    
    func checkAuth() -> Bool {
        return isLoggedIn
    }
    
    func signUp(email: String, password: String, completion: @escaping (() -> Void)) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error {
                AlertModel.shared.showOkAlert(title: "Error", message: error.localizedDescription)
                return
            }
            self?.isLoggedIn = true
            self?.user = User(email: email)
            completion()
        }
    }
    
    func login(email: String, password: String, completion: @escaping (() -> Void)) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error {
                AlertModel.shared.showOkAlert(title: "Error", message: error.localizedDescription)
                return
            }
            self?.isLoggedIn = true
            self?.user = User(email: email)
            completion()
        }
    }
    
    func signOut() {
        isLoggedIn = false
        user = nil
    }
}
