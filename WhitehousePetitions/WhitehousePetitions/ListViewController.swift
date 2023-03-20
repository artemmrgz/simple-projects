//
//  ListViewController.swift
//  WhitehousePetitions
//
//  Created by Artem Marhaza on 18/03/2023.
//

import UIKit

class ListViewController: UIViewController {
    
    let tableView = UITableView()
    
    var petitions = [Petition]()
    var petitionsManager: PetitionsMenageable = PetitionsManager()
    
    let urlString: String
    let titleName: String
    
    init(urlString: String, titleName: String) {
        self.urlString = urlString
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titleName
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .systemBackground
        setupTable()
        fetchData(urlString: urlString)
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

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let petition = petitions[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reuseID, for: indexPath) as! CustomCell
        cell.configureWith(title: petition.title, subtitle: petition.body)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ListViewController {
    private func fetchData(urlString: String) {
        petitionsManager.fetchPetitions(url: urlString) { result in
            switch result {
            case .success(let petitions):
                self.petitions = petitions.results
                self.tableView.reloadData()
            case .failure(let error):
                self.showError(error)
            }
        }
    }
    
    private func showError(_ error: NetworkError) {
        let (title, message) = getTitleAndMessage(for: error)
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    func getTitleAndMessage(for error: NetworkError) -> (String, String) {
        let title: String
        let message: String
        
        switch error {
        case .serverError:
            title = "Server Error"
            message = "Ensure you are connected to the internet. Please try again."
        case .decodingError:
            title = "Error"
            message = "We could not process your request. Please try again."
        }
        
        return (title, message)
    }
}
