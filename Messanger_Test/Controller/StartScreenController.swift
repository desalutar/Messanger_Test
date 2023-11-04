//
//  AuthorizationController.swift
//  Messenger
//
//  Created by Ишхан Багратуни on 01.11.23.
//

import UIKit
    
final class StartScreenController: UIViewController, Storyboardable {
    
    weak var coordinator: AppCoordinator?
    private var viewItems = ViewItems(viewType: .startScreen)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = viewItems
        viewItems.configure()
        viewItems.delegate = self
    }
    
}

extension StartScreenController: ViewItemsDelegate {
    func switchToRegistrationController() {
        coordinator?.openRegistrationVC()
        
    }
    
    func switchToAuthorizationController() {
        coordinator?.openAuthorizationVC()
    }
}

