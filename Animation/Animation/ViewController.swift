//
//  ViewController.swift
//  Animation
//
//  Created by Artem Marhaza on 03/04/2023.
//

import UIKit

class ViewController: UIViewController {
    
    var tapButton = UIButton()
    var imageView = UIImageView(image: UIImage(named: "penguin"))
    
    var currentAnimation = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        tapButton.setTitle("Tap", for: .normal)
        tapButton.addTarget(self, action: #selector(tapButtonTapped), for: .touchUpInside)
        
        tapButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tapButton)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            tapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tapButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func tapButtonTapped(_ sender: UIButton) {
        sender.isHidden = true
        
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, animations: {
            switch self.currentAnimation {
            case 0:
                self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
            case 1:
                self.imageView.transform = .identity
            case 2:
                self.imageView.transform = CGAffineTransform(translationX: -200, y: -200)
            case 3:
                self.imageView.transform = .identity
            case 4:
                self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
            case 5:
                self.imageView.transform = .identity
            case 6:
                self.imageView.alpha = 0.2
                self.imageView.backgroundColor = .gray
            case 7:
                self.imageView.alpha = 1
                self.imageView.backgroundColor = .clear
            default:
                break
            }
        }) { finished in
            sender.isHidden = false
        }
        currentAnimation += 1
        
        if currentAnimation > 7 {
            currentAnimation = 0
        }
        
    }


}

