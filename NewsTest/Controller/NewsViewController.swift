//
//  ViewController.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 16.02.2023.
//

import UIKit

class NewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkAuth()
    }
    
    private func checkAuth() {
        if FirebaseManager.shared.checkAuth() {
            return
        } else {
            let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "LoginViewController")
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
    }


}

