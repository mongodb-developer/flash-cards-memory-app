//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 5/9/21.
//

import Foundation
import FlashCardsDataEntities
import FlashCardsModels
import FlashCardsDataEntitiesImpl
import FlashCardsModelsImpl

public struct DeckEntityToDeckMapperImpl: Mapper {
    
    public typealias InType = DeckEntityImpl
    public typealias OutType = FlashCardDeck
    
    public init() {}
    
    public func map(_ inData: InType) -> OutType {
        
        let cards = CardEntityToFlashCardMapperImpl().map(cardEntities: inData.cards)
        
        let deck = FlashCardDeck(title: inData.title,
                                    description: inData.deckDescription,
                                    icon: inData.icon,
                                    creationDate: inData.creationDate,
                                    lastUpdateDate: inData.lastUpdateDate,
                                    cards: cards)
        return deck
    }
    
    public func map(deckEntities: [DeckEntityImpl]) -> [Deck] {
        var returnDecks: [FlashCardDeck] = []
        
        for deckEntity in deckEntities {
            if let entity = map(deckEntity) as? FlashCardDeck {
                returnDecks.append(entity)
            }
        }
        
        return returnDecks
    }
}

public struct CardEntityToFlashCardMapperImpl: Mapper {
    
    public typealias InType = CardEntityImpl
    public typealias OutType = FlashCard
    
    public init() {}

    public func map(_ inData: InType) -> OutType {
        let card = FlashCard(title: inData.title,
                               description: inData.backText,
                               icon: inData.icon,
                               creationDate: inData.creationDate,
                               lastUpdateDate: inData.lastUpdateDate)
            
        return card
    }
    
    public func map(cardEntities: [CardEntity]) -> [Card] {
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
