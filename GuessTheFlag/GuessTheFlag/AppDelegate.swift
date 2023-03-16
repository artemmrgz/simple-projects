//
//  AppDelegate.swift
//  GuessTheFlag
//
//  Created by Artem Marhaza on 16/03/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController()
        
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }
}

