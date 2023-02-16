//
//  LoginViewController.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 16.02.2023.
//

import UIKit

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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.setViewControllers([vc], animated: true)
    }

    @IBAction func didTapSignUpButton(_ sender: UIButton) {
        isSignUp.toggle()
    }
    
    @IBAction func didTapResetPassword(_ sender: UIButton) {
        
    }
    
}
