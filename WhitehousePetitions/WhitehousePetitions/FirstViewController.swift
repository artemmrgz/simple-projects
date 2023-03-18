//
//  ViewController.swift
//  WhitehousePetitions
//
//  Created by Artem Marhaza on 18/03/2023.
//

import UIKit

class FirstViewController: UIViewController {
    
    let tableView = UITableView()
    
    var petitions = [Petition]()
    let petitionsManager: PetitionsMenageable = PetitionsManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupTable()
        fetchData(url: "https://www.hackingwithswift.com/samples/petitions-1.json")
        
    }
    
    private func setupTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource =  self
        
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.reuseID)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let petition = petitions[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reuseID, for: indexPath) as! CustomCell
        cell.configureWith(title: petition.title, subtitle: petition.body)
        
        return cell
    }
}

extension FirstViewController {
    private func fetchData(url: String) {
        petitionsManager.fetchPetitions(url: url) { result in
            switch result {
            case .success(let petitions):
                print("tut")
                self.petitions = petitions.results
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
