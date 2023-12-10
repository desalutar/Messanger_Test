//
//  RegistrationViewController.swift
//  Messenger
//
//  Created by Ишхан Багратуни on 01.11.23.
//

import UIKit
import Firebase

final class RegistrationViewController: UIViewController, RegistrationDelegate {
    
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
    
    func saveUserModel(with item: UserModel) {
//        navigationController?.popViewController(animated: true)
        coordinator?.pop()
    }
    
    /* 
     Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
     
    }
     */
}
