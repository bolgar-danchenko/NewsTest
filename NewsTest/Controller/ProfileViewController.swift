//
//  ProfileViewController.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 16.02.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User = User(email: "")
    
    convenience init(user: User) {
        self.init()
        self.user = user
    }
    
    private lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ProfileImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        label.textAlignment = .left
        label.paddingLeft = 10
        label.layer.backgroundColor = CGColor(red: 0.459, green: 0.573, blue: 0.867, alpha: 0.1)
        label.layer.cornerRadius = 20
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.6)
        label.textAlignment = .left
        label.paddingLeft = 10
        label.layer.backgroundColor = CGColor(red: 0.459, green: 0.573, blue: 0.867, alpha: 0.1)
        label.layer.cornerRadius = 20
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.systemRed, for: .normal)
        button.setTitle("Sign Out", for: .normal)
        button.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background")
        configure()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(signOutButton)
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 100),
            profileImage.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 37),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            nameLabel.heightAnchor.constraint(equalToConstant: 44),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            emailLabel.heightAnchor.constraint(equalToConstant: 44),
            
            signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
        ])
    }
    
    private func configure() {
        nameLabel.text = user.name
        emailLabel.text = user.email
    }
    
    @objc private func didTapSignOut() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController?.setViewControllers([vc], animated: true)
    }
}
