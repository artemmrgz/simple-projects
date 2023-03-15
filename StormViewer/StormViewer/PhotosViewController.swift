//
//  PhotosViewController.swift
//  StormViewer
//
//  Created by Artem Marhaza on 14/03/2023.
//

import UIKit

class PhotosViewController: UIViewController {
    
    let tableView = UITableView()
    let photos: [String] = {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        return items.filter {$0.hasPrefix("nssl") }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PhotoCell.self, forCellReuseIdentifier: PhotoCell.reuseID)
        tableView.rowHeight = PhotoCell.rowHeight
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PhotosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image = photos[indexPath.row]
        let vc = DetailViewController(imageName: image)
        vc.title = "Photo number \(indexPath.row + 1) of \(photos.count)"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PhotosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photoName = photos[indexPath.row]
        let labelName = "Photo \(photoName)"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.reuseID, for: indexPath) as! PhotoCell
        cell.configureWith(labelName: labelName, imageName: photoName) 
        return cell
    }
}
