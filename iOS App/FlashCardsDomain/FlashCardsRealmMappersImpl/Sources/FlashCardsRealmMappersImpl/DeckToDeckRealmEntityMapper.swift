//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 7/9/21.
//

import Foundation
import FlashCardsDataEntities
import FlashCardsModels
import FlashCardsDataEntitiesRealmImpl
import FlashCardsModelsImpl

public struct DeckToDeckRealmEntityMapper: Mapper {
    public typealias InType = FlashCardDeck
    public typealias OutType = DeckEntityRealmImpl

    public init() {}

    public func map(_ inData: InType) -> OutType {
        
        let cards = CardToCardRealmEntityMapper().map(cards: inData.cards as! [FlashCard])
                
        let deck = DeckEntityRealmImpl(title: inData.title,
                                       description: inData.description,
                                       icon: inData.icon,
                                       creationDate: inData.creationDate,
                                       lastUpdateDate: inData.lastUpdateDate,
                                       cards: cards)
        return deck
    }
    
    public func map(deckEntities: [FlashCardDeck]) -> [DeckEntityRealmImpl] {
        var returnDecks: [DeckEntityRealmImpl] = []
        
        for deckEntity in deckEntities {
            let entity = map(deckEntity)
            returnDecks.append(entity)
        }
        
        return returnDecks
    }
}

public struct CardToCardRealmEntityMapper: Mapper {
    
    public typealias InType = FlashCard
    public typealias OutType = CardEntityRealmImpl
    
    public init() {}
    
    public func map(_ inData: InType) -> OutType {
        let cardEntity = CardEntityRealmImpl(title: inData.title,
                                        description: inData.description,
                                        icon: inData.icon,
                                        creationDate: inData.creationDate,
                                        lastUpdateDate: inData.lastUpdateDate)
        
        return cardEntity
    
    }

    public func map(cards: [FlashCard]) -> [CardEntityRealmImpl] {
        var returnCards: [CardEntityRealmImpl] = []
        
        for card in cards {
            let card = map(card)
            returnCards.append(card)
        }
        
        return returnCards
    }
}
