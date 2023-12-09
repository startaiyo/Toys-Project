//
//  AppDelegate.swift
//  Toys Etude
//
//  Created by Shotaro Doi on 2023/12/09.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyBoard = UIStoryboard(name: "ViewController",
                                      bundle: nil)
        let rootVC = storyBoard.instantiateViewController(withIdentifier: "RootViewController")
        let navCon = UINavigationController()
        navCon.setViewControllers([rootVC],
                                  animated: true)
        window?.rootViewController = navCon
        window?.makeKeyAndVisible()
        return true
    }
}

