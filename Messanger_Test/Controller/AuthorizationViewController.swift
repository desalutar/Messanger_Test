//
//  AuthorizationViewController.swift
//  Messenger
//
//  Created by Ишхан Багратуни on 01.11.23.
//

import UIKit

final class AuthorizationViewController: UIViewController {

    private let viewItems = ViewItems(viewType: .authorizationScreen)
    override func viewDidLoad() {
        super.viewDidLoad()
        view = viewItems
        viewItems.configure()
    }

}
