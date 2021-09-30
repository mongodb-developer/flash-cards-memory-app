//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 7/9/21.
//

import Foundation
import FlashCardsDataEntities
import FlashCardsModels
import RealmSwift
//import FlashCardsMappers
import FlashCardsDataEntitiesRealmImpl
import FlashCardsModelsImpl

public struct DeckRealmEntityToDeckMapper: Mapper {
    public typealias InType = DeckEntityRealmImpl
    public typealias OutType = FlashCardDeck

    public init() {}
    
    public func map(_ inData: InType) -> OutType {
        
        let cards = CardRealmEntityToCardMapper().map(inData.realmCards)
        
        let deck = FlashCardDeck(title: inData.title,
                                    description: inData.deckDescription,
                                    icon: inData.icon,
                                    creationDate: inData.creationDate,
                                    lastUpdateDate: inData.lastUpdateDate,
                                    cards: cards)
        return deck
    }
    
    public func map(deckEntities: [DeckEntityRealmImpl]) -> [Deck] {
        var returnDecks: [FlashCardDeck] = []
        
        for deckEntity in deckEntities {
            let entity = map(deckEntity)
            returnDecks.append(entity)
        }
        
        return returnDecks
    }
}

public struct CardRealmEntityToCardMapper: Mapper {
    
    public typealias InType = List<CardEntityRealmImpl>
    public typealias OutType = [Card]
    
    public init() {}

    public func map(_ inData: InType) -> OutType {
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
