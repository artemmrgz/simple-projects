//
//  ViewControllers+Utils.swift
//  WhitehousePetitions
//
//  Created by Artem Marhaza on 18/03/2023.
//

import UIKit

extension UIViewController {
    func setTabBarImage(imageName: String, title: String) {
        let config = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: config)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}
