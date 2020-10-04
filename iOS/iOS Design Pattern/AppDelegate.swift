//
//  AppDelegate.swift
//  iOS Design Pattern
//
//  Created by 박은비 on 2020/10/02.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: MainCoordinator?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // create the main navigation controller to be used for our app
        let navigation = UINavigationController()

        coordinator = MainCoordinator(navigationController: navigation)
        coordinator?.start()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible() 
        return true
    }
}

