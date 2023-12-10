//
//  AuthorizationViewController.swift
//  Messenger
//
//  Created by Ишхан Багратуни on 01.11.23.
//

import UIKit
import FirebaseAuth
import Firebase

final class AuthorizationViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    private let authorizationViews = AuthorizationViews()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = authorizationViews
        authorizationViews.delegate = self
        hideKeyboard()
    }
    
    fileprivate func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapToClose))
        view.addGestureRecognizer(tap)
    }
    @objc func tapToClose() {
        view.endEditing(true)
    }
    
}

extension AuthorizationViewController: AuthorizationViewsDelegate {
    func signInAccount() {
        Auth.auth().signIn(withEmail: authorizationViews.emailField.text!,
                           password: authorizationViews.passwordField.text!) { (result, error) in
            if error != nil {
                print("qwerty")
            } else {
                print("Вход успешен")
            }
        }
    }

}
