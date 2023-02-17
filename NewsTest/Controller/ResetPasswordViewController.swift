//
//  ResetPasswordViewController.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 16.02.2023.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapReset(_ sender: UIButton) {
        guard let email = emailTextField.text,
              !email.isEmpty else {
            AlertModel.shared.showOkAlert(title: "Attention", message: "Email cannot be empty")
            return
        }
        
        if isValidEmail(email: email) {
            let alert = UIAlertController(title: "Success", message: "Your password has been reset", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true)
        } else {
            AlertModel.shared.showOkAlert(title: "Error", message: "This email address is invalid")
        }
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        
        return emailValidationPredicate.evaluate(with: email)
    }
}
