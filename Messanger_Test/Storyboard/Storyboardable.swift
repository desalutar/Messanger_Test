//
//  Storybordable.swift
//  Messanger_Test
//
//  Created by Ишхан Багратуни on 04.11.23.
//

import Foundation
import UIKit
protocol Storyboardable {
    static func createObject() -> Self
}

extension Storyboardable where Self: UIViewController {
    static func createObject() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
