//
//  AppDelegate.swift
//  MVVM-C
//
//  Created by Valiantsin Vasiliavitski on 11/22/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var mainCoordinator: Coordinator?
    
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        let loginCoordinator = LoginCoordinator(navigationVC: navigationController)
        mainCoordinator = loginCoordinator
        loginCoordinator.start()
        window?.makeKeyAndVisible()
        return true
    }

}

