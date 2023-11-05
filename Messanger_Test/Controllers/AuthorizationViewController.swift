//
//  AuthorizationViewController.swift
//  Messenger
//
//  Created by Ишхан Багратуни on 01.11.23.
//

import UIKit

final class AuthorizationViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    private let authorizationViews = AuthorizationViews()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = authorizationViews
    }
    
}
