//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 7/9/21.
//

import Foundation
import FlashCardsNetwork
import FlashCardsDataEntities
import FlashCardsDataEntitiesImpl
import FlashCardsModels
import FlashCardsUseCases
import FlashCardsRepositoriesRealmImpl
import RealmSwift

public struct DeckRealmEntityToDeckMapper: Mapper {
    public typealias InType = DeckEntityRealmImpl
    public typealias OutType = FlashCardDeck

    public init() {}
    
    public func map(inData: InType) -> OutType {
        
        let cards = CardRealmEntityToCardMapper().map(inData: inData.realmCards)
        
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
            let entity = map(inData: deckEntity)
            returnDecks.append(entity)
        }
        
        return returnDecks
    }
}

public struct CardRealmEntityToCardMapper: Mapper {
    
    public typealias InType = List<CardEntityRealmImpl>
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
