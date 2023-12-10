//
//  RegistrationViewController.swift
//  Messenger
//
//  Created by Ишхан Багратуни on 01.11.23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

final class RegistrationViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    private let registrationViews = RegistrationViews()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = registrationViews
        registrationViews.delegate = self
        hideKeyboard()
    }
    
    fileprivate func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapToClose))
        view.addGestureRecognizer(tap)
    }
    @objc func tapToClose() {
        view.endEditing(true)
    }
    
    
    /* 
     Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
     
    }
     */
}

extension RegistrationViewController: RegistrationDelegate {
    func saveUserModel(with item: UserModel) {
        coordinator?.pop()
    }
    
    func checkValid() {
        Auth.auth().createUser(withEmail: registrationViews.emailField.text!, 
                               password: registrationViews.passwordField.text!) { result, error in
//            if error == nil {
//                print("ERROR!!!")
//            } else {
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: [
                    "email": self.registrationViews.emailField.text!,
                    "name": self.registrationViews.userName.text!,
                    "password": self.registrationViews.passwordField.text!,
                    "uid": result!.user.uid
                ]) { (error) in
                    if error != nil {
                        print("error saving user in database")
                    }
                }
                print("Jump to the next screen!")
            }
        }
    }
//}
