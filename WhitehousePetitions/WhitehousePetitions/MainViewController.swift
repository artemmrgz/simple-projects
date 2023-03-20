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
        
        let allPetitionsVC = ListViewController(urlString: "https://www.hackingwithswift.com/samples/petitions-1.json", titleName: "All Petitions")
        let popularPetitionsVC = ListViewController(urlString: "https://www.hackingwithswift.com/samples/petitions-2.json", titleName: "Popular Petitions")
        
        allPetitionsVC.setTabBarImage(imageName: "book", title: "All petitions")
        popularPetitionsVC.setTabBarImage(imageName: "bookmark", title: "Popular petitions")
        
        let allPetitionsNC = UINavigationController(rootViewController: allPetitionsVC)
        let popularPetitionsNC = UINavigationController(rootViewController: popularPetitionsVC)
        
        viewControllers = [allPetitionsNC, popularPetitionsNC]
    }


}
