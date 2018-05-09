//
//  ViewController.swift
//  Concentration
//
//  Created by Georgi Teoharov on 28.02.18.
//  Copyright © 2018 Georgi Teoharov. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    
    private lazy var game  = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        get {
            return (cardButtons.count + 1) / 2
        }
    }

    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    private func updateScoreLabel() {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Score: 0", attributes: attributes)
        scoreLabel.attributedText = attributedString
        
    }
    
    @IBOutlet private weak var scoreLabel: UILabel! {
        didSet {
            updateScoreLabel()
        }
    }
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func newGame(_ sender: UIButton) {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "New Game", attributes: attributes)
        sender.setAttributedTitle(attributedString, for: .normal)
        resetCards()
        updateViewFromModel()
        
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            print(cardNumber)
            updateViewFromModel()
        } else {
            print("card number is not in cardButton")
        }
    }
    
    private func updateViewFromModel() {
        for index in 0..<cardButtons.count {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            }
        }
    }
    
    func resetCards() {
        Card.identifierFactory = 0
        game = Concentration(numberOfPairsOfCards: cardButtons.count / 2)
        flipCount = 0
    }
    
    var theme: String? {
        didSet {
            emojiChoise = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    
    private var emojiChoise = "🎃👻🐸🦅🦂🕷🐿🦃🍄🎁"
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoise.count > 0 {
            let randomStringIndex = emojiChoise.index(emojiChoise.startIndex, offsetBy: emojiChoise.count.arc4random)
            emoji[card] = String(emojiChoise.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }

}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

