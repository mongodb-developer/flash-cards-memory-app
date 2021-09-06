//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 5/9/21.
//

import Foundation
import FlashCardsNetwork
import FlashCardsDataEntities
import FlashCardsDataEntitiesImpl
import FlashCardsModels

struct DeckEntityToDeckMapper {
    static func map(decks: [DeckEntity]) -> [Deck] {
        var returnEntities: [FlashCardDeck] = []
        
        for deck in decks {
            let cards = CardEntityToFlashCardMapper.map(cardEntities: deck.cards)
            
            let deck = FlashCardDeck(title: deck.title,
                                        description: deck.deckDescription,
                                        icon: deck.icon,
                                        creationDate: deck.creationDate,
                                        lastUpdateDate: deck.lastUpdateDate,
                                        cards: cards)
            returnEntities.append(deck)
        }
        
        return returnEntities
    }
}

struct CardEntityToFlashCardMapper {
    static func map(cardEntities: [CardEntity]) -> [Card] {
        var returnEntities: [FlashCard] = []
        
        for cardEntity in cardEntities {

            let card = FlashCard(title: cardEntity.title,
                                   description: cardEntity.backText,
                                   icon: cardEntity.icon,
                                   creationDate: cardEntity.creationDate,
                                   lastUpdateDate: cardEntity.lastUpdateDate)
            
            returnEntities.append(card)
        }
        
        return returnEntities
    }
}
