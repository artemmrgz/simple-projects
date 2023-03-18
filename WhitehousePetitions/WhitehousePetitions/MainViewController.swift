//
//  MainViewController.swift
//  WhitehousePetitions
//
//  Created by Artem Marhaza on 18/03/2023.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        
        let firstVC = FirstViewController()
        let secondVC = SecondViewController()
        
        firstVC.setTabBarImage(imageName: "book", title: "All petitions")
        secondVC.setTabBarImage(imageName: "bookmark", title: "Saved petitions")
        
        let firstNC = UINavigationController(rootViewController: firstVC)
        let secondNC = UINavigationController(rootViewController: secondVC)
        
        viewControllers = [firstNC, secondNC]
    }


}
