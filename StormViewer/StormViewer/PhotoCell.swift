//
//  PhotosCell.swift
//  StormViewer
//
//  Created by Artem Marhaza on 15/03/2023.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    static let reuseID = "PhotosCell"
    static let rowHeight: CGFloat = 80
    let photoView: UIImageView = {
        let photoView = UIImageView()
        photoView.image = UIImage(systemName: "questionmark")
        return photoView
    }()
    let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoCell {
    private func setup() {
        self.accessoryType = .disclosureIndicator
        contentView.addSubview(photoView)
        contentView.addSubview(nameLabel)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            photoView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            photoView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            photoView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            photoView.widthAnchor.constraint(equalTo: photoView.heightAnchor)
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.textAlignment = .left
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: photoView.trailingAnchor, multiplier: 2),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configureWith(labelName: String, imageName: String) {
        let image = UIImage(named: imageName)
        photoView.image = image
        nameLabel.text = labelName
    }
}
