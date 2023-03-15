//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Artem Marhaza on 14/03/2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    let imageView = UIImageView()
    var imageName: String

    init(imageName: String) {
        self.imageName = imageName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = view.bounds
    }
    
    private func setup() {
        navigationItem.largeTitleDisplayMode = .never
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        view.addSubview(imageView)
    }
}

