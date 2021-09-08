//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 25/8/21.
//

import Foundation
import FlashCardsModels

public struct FlashCardDeck: Deck {
    public let title: String
    public let description: String
    public let icon: String
    public let creationDate: Date
    public let lastUpdateDate: Date
    public let cards: [Card]

    public init(title: String,
                description: String,
                icon: String,
                creationDate: Date,
                lastUpdateDate: Date,
                cards: [Card]) {
        self.title = title
        self.description = description
        self.icon = icon
        self.creationDate = creationDate
        self.lastUpdateDate = lastUpdateDate
        self.cards = cards
    }
    
    public static func from(deck: Deck, addingCard card: Card) -> FlashCardDeck {
        var mutableCards = deck.cards
        
        mutableCards.append(card)
        
        let deck = FlashCardDeck(title: deck.title,
                                 description: deck.description,
                                 icon: deck.icon,
                                 creationDate: deck.creationDate,
                                 lastUpdateDate: deck.lastUpdateDate,
                                 cards: mutableCards)
        return deck
    }
}
