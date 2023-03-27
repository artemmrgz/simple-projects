//
//  ViewController.swift
//  Hangman
//
//  Created by Artem Marhaza on 24/03/2023.
//

import UIKit

class ViewController: UIViewController {
    
    var scoreLabel: UILabel!
    var wordField: UITextField!
    var usedLetters = [String]()
    var wordsCollection = [String]()
    var guessButton: UIButton!
    
    var score = 7 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var wordToGuess = "" {
        didSet {
            wordLettersSet = Set(wordToGuess.map {String($0)})
        }
    }
    var wordToDisplay = "" {
        didSet {
            wordField.text = wordToDisplay
        }
    }
    var wordLettersSet = Set<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen
        setup()
        layout()
        play()
    }
}

extension ViewController {
    private func setup() {
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont.preferredFont(forTextStyle: .body)
        scoreLabel.text = "Score: 7"
        
        wordField = UITextField()
        wordField.translatesAutoresizingMaskIntoConstraints = false
        wordField.font = UIFont.systemFont(ofSize: 30)
        wordField.textAlignment = .center
        wordField.isUserInteractionEnabled = false
        
        guessButton = UIButton(configuration: .filled())
        guessButton.translatesAutoresizingMaskIntoConstraints = false
        guessButton.setTitle("Guess letter", for: .normal)
        guessButton.addTarget(self, action: #selector(guessButtonTapped), for: .touchUpInside)
    }
    
    private func layout() {
        view.addSubview(scoreLabel)
        view.addSubview(wordField)
        view.addSubview(guessButton)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -8),
            
            wordField.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 32),
            wordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            guessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            guessButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension ViewController {
    private func loadWords() {
        if let fileURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let words = try? String(contentsOf: fileURL) {
                var wordsArray = words.components(separatedBy: "\n")
                
                if wordsArray.last == "" {
                    wordsArray.removeLast()
                }
                wordsCollection += wordsArray
            }
        }
    }
    
    private func displayWordToGuess() {
        let word = wordsCollection[Int.random(in: 0..<wordsCollection.count)]
        
        wordToGuess = word.uppercased()
        
        for _ in word {
            wordToDisplay += "?"
        }
    }
    
    private func checkLetter(letter: String) {
        if !wordToGuess.contains(letter) {
            displayAlert(alertTitle: "Incorrect letter", alertMessage: nil, actionTitle: "OK") { _ in
                self.score -= 1
            }
            return
        }
        
        wordToDisplay = ""
        usedLetters.append(letter)
        
        for char in wordToGuess {
            let letter = String(char)
            
            if usedLetters.contains(letter) {
                wordToDisplay += letter
            } else {
                wordToDisplay += "?"
            }
        }
        
        if Set(usedLetters) == wordLettersSet {
            displayAlert(alertTitle: "Congratulations!", alertMessage: "You've guessed the word!", actionTitle: "OK", handler: nil)
        }
    }
    
    private func displayAlert(alertTitle: String, alertMessage: String?, actionTitle: String, handler: ((UIAlertAction) -> ())?) {
        let ac = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default, handler: handler)
        ac.addAction(action)
        present(ac, animated: true)
    }
    
    
    private func play() {
        loadWords()
        displayWordToGuess()
        
    }
}

extension ViewController {
    @objc func guessButtonTapped(sender: UIButton) {
        let ac = UIAlertController(title: "Type your letter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let action = UIAlertAction(title: "Submit", style: .default) { _ in
            guard let letter = ac.textFields?[0].text else { return }
            if letter.count == 1 {
                self.checkLetter(letter: letter.uppercased())
            } else {
                return
            }
        }
        ac.addAction(action)
        present(ac, animated: true)
    }
}
