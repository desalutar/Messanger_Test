///
//  Model.swift
//  Messenger
//
//  Created by Ишхан Багратуни on 01.11.23.
//

import Foundation
import UIKit

struct UserModel {
    let name: String
    let login: String
    let password: String
    let photo: UIImage?
    
    init(name: String, login: String,
         password: String, photo: UIImage?) {
        self.name = name
        self.login = login
        self.password = password
        self.photo = photo
    }
}
