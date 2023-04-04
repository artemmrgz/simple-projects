//
//  CustomCell.swift
//  SelfieShare
//
//  Created by Artem Marhaza on 04/04/2023.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    static let reuseID = "CustomCell"
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 145, height: 145))
        imageView.tag = 1000
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(imageView)
    }
}
