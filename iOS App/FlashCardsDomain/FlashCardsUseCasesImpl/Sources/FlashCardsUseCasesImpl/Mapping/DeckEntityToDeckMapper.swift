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
import FlashCardsUseCases

// DeckEntity --> Deck
public struct DeckEntityToDeckMapper: Mapper {
    
    public typealias InType = DeckEntity
    public typealias OutType = Deck

    public init() {}
    
    public func map(inData: InType) -> OutType {
        
        let cards = CardEntityToFlashCardMapper().map(inData: inData.cards)
        
        let deck = FlashCardDeck(title: inData.title,
                                    description: inData.deckDescription,
                                    icon: inData.icon,
                                    creationDate: inData.creationDate,
                                    lastUpdateDate: inData.lastUpdateDate,
                                    cards: cards)
        return deck
    }
    
    public func map(deckEntities: [DeckEntity]) -> [Deck] {
        var returnDecks: [FlashCardDeck] = []
        
        for deckEntity in deckEntities {
            if let entity = map(inData: deckEntity) as? FlashCardDeck {
                returnDecks.append(entity)
            }
        }
        
        return returnDecks
    }
}

public struct CardEntityToFlashCardMapper: Mapper {
    
    public typealias InType = [CardEntity]
    public typealias OutType = [Card]
    
    public init() {}

    public func map(inData: InType) -> OutType {
        var returnEntities: [FlashCard] = []
        
        for cardEntity in inData {

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
