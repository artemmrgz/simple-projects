//
//  ViewController.swift
//  WordScramble
//
//  Created by Artem Marhaza on 17/03/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetTapped))
        
        setupTable()
        loadContentOf("start", withExtension: "txt", into: allWords)
        startGame()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
}

extension ViewController {
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
    }
    
    private func loadContentOf(_ fileName: String, withExtension fileExtension: String, into container: [String]) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileExtension) else { return }
        guard let content = try? String(contentsOf: url) else { return }
        
        allWords = content.components(separatedBy: "\n")
    }
    
    private func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    private func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        guard (title?.lowercased()) != nil else { return }
        
        switch lowerAnswer {
        case _ where lowerAnswer == title:
            showErrorMessage(title: "Same word!",
                             message: "You can't submit the same word")
        case _ where lowerAnswer.count < 3:
            showErrorMessage(title: "Word is too short!",
                             message: "Word should be at least 3 letters long")
        case _ where !isPossible(word: lowerAnswer):
            showErrorMessage(title: "Word not possible",
                             message: "You can't spell that word from \(title!.lowercased())")
        case _ where !isReal(word: lowerAnswer):
            showErrorMessage(title: "Word not recognized",
                             message: "You can't just make them up, you know!")
        case _ where !isOriginal(word: lowerAnswer):
            showErrorMessage(title: "Word already used",
                             message: "Be more original!")
        default:
            usedWords.insert(lowerAnswer, at: 0)
            let path = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [path], with: .automatic)
        }
    }
    
    private func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    private func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    private func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
        
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
}

extension ViewController {
    @objc func plusTapped() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let action = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
            }
        
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    @objc func resetTapped() {
        startGame()
    }
}
