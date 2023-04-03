//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Artem Marhaza on 16/03/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let stackView = UIStackView()
    let countryLabel = UILabel()
    let flagButton1 = UIButton()
    let flagButton2 = UIButton()
    let flagButton3 = UIButton()
    
    var countries = [String]()
    var buttons = [UIButton]()
    var score = 0
    var correctAnswer: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        play()
    }
}

extension ViewController {
    private func setup() {
        view.backgroundColor = .systemBackground
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 32
        
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.textAlignment = .center
        countryLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        countryLabel.textColor = .darkGray
        
        stackView.addArrangedSubview(countryLabel)
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        buttons += [flagButton1, flagButton2, flagButton3]
        
        for (idx, btn) in buttons.enumerated() {
            btn.layer.borderWidth = 3
            btn.layer.borderColor = UIColor.lightGray.cgColor
            btn.layer.cornerRadius = 20
            btn.clipsToBounds = true
            
            btn.tag = idx
            btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
            stackView.addArrangedSubview(btn)
        }

        view.addSubview(stackView)
       
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 12),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 12),
        ])
    }
    
    private func play(action: UIAlertAction! = nil) {
        countries.shuffle()
        stackView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        for (idx, btn) in buttons.enumerated() {
            btn.transform = .identity
            let image = UIImage(named: countries[idx])
            btn.setImage(image, for: .normal)
        }
        
        correctAnswer = Int.random(in: 0...2)
        countryLabel.text = countries[correctAnswer!]
        
        UIView.animate(withDuration: 1, delay: 0) {
            self.stackView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    private func generateNumbers(_ amount: Int, in total: Int) -> [Int] {
        var numbers = [Int]()
            
        while numbers.count <= amount {
            let num = Int.random(in: 0..<total)
            if !numbers.contains(num) {
                numbers.append(num)
            }
        }
        return numbers
    }
}

extension ViewController {
    @objc func buttonTapped(_ sender: UIButton) {
        var title: String
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5) {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
        
        if sender.tag == correctAnswer {
            score += 1
            title = "Correct answer 🥳"
        } else {
            score -= 1
            title = "Wrong answer 😔"
        }
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: play))
        present(ac, animated: true)
    }
}
