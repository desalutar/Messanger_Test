//
//  AppDelegate.swift
//  Messanger_Test
//
//  Created by Ишхан Багратуни on 02.11.23.
//

import UIKit
import FirebaseCore
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? 
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navigationController = UINavigationController()
        let chatVC = ChatsTableViewController()
        coordinator = AppCoordinator(navigationController: navigationController)
        coordinator?.start()
         
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = /*navigationController*/ chatVC
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        return true
    }


}

