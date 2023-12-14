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
}

extension RegistrationViewController: RegistrationDelegate {
    func registrationUser(with email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email,
                               password: password) {result, error in
            if error != nil {
                print("ERROR!!!")
            } else {
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: [
                    "email": email,
                    "name": name,
                    "password": password,
                    "uid": result!.user.uid,
                ]) { (error) in
                    if error != nil {
                        print("error saving user in database")
                    }
                }
                self.coordinator?.pop()
            }
        }
    }
    
}
