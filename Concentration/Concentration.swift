//
//  Concentration.swift
//  Concentration
//
//  Created by Georgi Teoharov on 28.02.18.
//  Copyright © 2018 Georgi Teoharov. All rights reserved.
//


import Foundation



struct Concentration
{
    private(set) var cards = [Card]()
    
    private var indexOfAndOnlyOneFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
//            var foundIndex: Int?
//            for index in cards.indices {
//                if  cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    }
//                    else {
//                        foundIndex = nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
        
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): choose index is not in the cards")
        if !cards[index].isMatched {
            if let matchedIndex = indexOfAndOnlyOneFaceUpCard, matchedIndex != index {
                // check if card is matched
                if cards[matchedIndex] == cards[index] {
                    cards[matchedIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                // eather no cards or 2 cards are face up
                indexOfAndOnlyOneFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init( \(numberOfPairsOfCards)) : You must have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        // TODO: Shuffle the cards
        cards.shuffle()
    }
}


extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}


extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}


