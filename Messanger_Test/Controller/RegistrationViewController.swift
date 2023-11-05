//
//  RegistrationViewController.swift
//  Messenger
//
//  Created by Ишхан Багратуни on 01.11.23.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    weak var coordinator: AppCoordinator?
    private let registrationViews = RegistrationViews()
    
    override func loadView() {
        view = registrationViews
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
