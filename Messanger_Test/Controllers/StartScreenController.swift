//
//  AuthorizationController.swift
//  Messenger
//
//  Created by Ишхан Багратуни on 01.11.23.
//

import UIKit
    
final class StartScreenController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    private let startScreen = StartScreenViews()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = startScreen
        startScreen.delegate = self
    }
    
}

extension StartScreenController: StartScreenDelegate {
    func switchToRegistrationController() {
        coordinator?.openRegistrationVC()
    }
    
    func switchToAuthorizationController() {
        coordinator?.openAuthorizationVC()
    }
}

