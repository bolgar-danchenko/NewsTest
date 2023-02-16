//
//  LoginViewController.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 16.02.2023.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    private var isSignUp = false {
        didSet {
            setupLayout()
        }
    }
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func setupLayout() {
        if isSignUp {
            title = "Sign Up"
            loginButton.setTitle("Sign Up", for: .normal)
            signUpLabel.text = "Already have an account?"
            signUpButton.setTitle("Log In", for: .normal)
            resetPasswordButton.isHidden = true
        } else {
            title = "Log In"
            loginButton.setTitle("Log In", for: .normal)
            signUpLabel.text = "Don't have an account?"
            signUpButton.setTitle("Sign Up", for: .normal)
            resetPasswordButton.isHidden = false
        }
    }

    @IBAction func didTapButton(_ sender: UIButton) {
        
        guard let email = emailField.text,
              let password = passwordField.text,
              !email.isEmpty,
              !password.isEmpty else {
            AlertModel.shared.showOkActionAlert(title: "Attention", message: "Email and password cannot be empty")
            return
        }
        
        if !isSignUp {
            FirebaseManager.shared.login(email: email, password: password) {
                self.dismiss(animated: true)
            }
        } else {
            FirebaseManager.shared.signUp(email: email, password: password) {
                self.dismiss(animated: true)
            }
        }
    }

    @IBAction func didTapSignUpButton(_ sender: UIButton) {
        isSignUp.toggle()
    }
    
}
