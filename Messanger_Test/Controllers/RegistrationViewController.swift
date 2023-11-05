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
    
    override func loadView() {
        view = registrationViews
        registrationViews.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func saveUser(with item: Model) {
        navigationController?.popToRootViewController(animated: true)
    }
}
