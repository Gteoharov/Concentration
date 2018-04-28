//
//  Card.swift
//  Concentration
//
//  Created by Georgi Teoharov on 28.02.18.
//  Copyright © 2018 Georgi Teoharov. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    var hashValue: Int { return identifier }
    
    static func ==(lhr: Card, rhs: Card) -> Bool {
        return lhr.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
