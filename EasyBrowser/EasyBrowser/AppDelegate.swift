//
//  AppDelegate.swift
//  EasyBrowser
//
//  Created by Artem Marhaza on 16/03/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemBackground
        
        let vc = ViewController()
        let nc = UINavigationController(rootViewController: vc)
        nc.navigationBar.isTranslucent = false
        
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        return true
    }

}

