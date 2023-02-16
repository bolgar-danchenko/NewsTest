//
//  LoginViewController.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 16.02.2023.
//

import UIKit

class LoginViewController: UIViewController {

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

    @IBAction func didTapButton(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.setViewControllers([vc], animated: true)
    }

    @IBAction func didTapSignUpButton(_ sender: UIButton) {
        title = "Sign Up"
        loginButton.setTitle("Sign Up", for: .normal)
        signUpLabel.text = "Already have an account?"
        signUpButton.setTitle("Log In", for: .normal)
        resetPasswordButton.isHidden = true
    }
    
    @IBAction func didTapResetPassword(_ sender: UIButton) {
    }
    
}
