//
//  RegistrationViewController.swift
//  Messenger
//
//  Created by Ишхан Багратуни on 01.11.23.
//

import UIKit

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
    
    func saveUser(with item: UserModel) {
        navigationController?.popToRootViewController(animated: true)
    }
}
