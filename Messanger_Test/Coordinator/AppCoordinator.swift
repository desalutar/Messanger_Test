//
//  AppCoordinator.swift
//  Messanger_Test
//
//  Created by Ишхан Багратуни on 04.11.23.
//

import UIKit

class AppCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = StartScreenController.createObject()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func openRegistrationVC() {
        let registrationVC = RegistrationViewController.createObject()
        registrationVC.coordinator = self
        navigationController.pushViewController(registrationVC, animated: true)
    }
    
    func openAuthorizationVC() {
        let authorizationVC = AuthorizationViewController.createObject()
        authorizationVC.coordinator = self
        navigationController.pushViewController(authorizationVC, animated: true)
    }
    
}
