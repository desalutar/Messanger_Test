//
//  CoordinatorProtocol.swift
//  Messanger_Test
//
//  Created by Ишхан Багратуни on 04.11.23.
//

import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get set }
    func start()
}
