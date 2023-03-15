//
//  AppDelegate.swift
//  StormViewer
//
//  Created by Artem Marhaza on 14/03/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = PhotosViewController()
        let nc = UINavigationController(rootViewController: vc)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        return true
    }

}

