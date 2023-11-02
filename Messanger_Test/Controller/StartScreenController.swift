//
//  AuthorizationController.swift
//  Messenger
//
//  Created by Ишхан Багратуни on 01.11.23.
//

import UIKit
    
final class StartScreenController: UIViewController {
    
    private var viewItems = ViewItems(viewType: .startScreen)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = viewItems
        viewItems.configure()
        viewItems.delegate = self
    }
    
}

extension StartScreenController : ViewItemsDelegate {
    func switchController() {
//        print("qwe")
        
    }
    
    
}

