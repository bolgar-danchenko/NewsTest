//
//  User.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 16.02.2023.
//

import Foundation
import UIKit

struct User {
    let id = UUID().uuidString
    var name: String
    var email: String
    let profileImage = UIImage(named: "ProfileImage")
}
