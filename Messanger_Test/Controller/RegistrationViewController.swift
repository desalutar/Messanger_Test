//
//  RegistrationViewController.swift
//  Messenger
//
//  Created by Ишхан Багратуни on 01.11.23.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    private let viewItems = ViewItems(viewType: .registrationScreen)
    
    override func loadView() {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = viewItems
        viewItems.delegate = self
        viewItems.configure()
    }
    
    
}
extension RegistrationViewController: ViewItemsDelegate {
    func switchController() {
        
    }
    
    
}

