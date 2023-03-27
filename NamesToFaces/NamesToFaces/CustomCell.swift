//
//  CustomCell.swift
//  NamesToFaces
//
//  Created by Artem Marhaza on 27/03/2023.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    static let reuseID = "CustomCell"
    
    let imageView = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(label)
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.borderColor = UIColor(white: 0, alpha: 0.5).cgColor
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = 3
        imageView.clipsToBounds = true
        
        label.textColor = .black
        label.font = UIFont(name: "Marker Felt", size: 16)
        label.textAlignment = .center
        contentView.layer.cornerRadius = 7
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            label.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureWith(title: String, imageFile: String) {
        label.text = title
        imageView.image = UIImage(contentsOfFile: imageFile)
    }
    
}


