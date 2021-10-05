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
import RealmSwift
import FlashCardsRealmInit

/// Maps from Domain (Deck) to Realm-based repository entity (DeckRealmEntity)
public struct DeckToDeckRealmEntityMapper: Mapper {
    public typealias InType = FlashCardDeck
    public typealias OutType = DeckEntityRealmImpl

    private let realm: Realm?
    
    public init(realm: Realm? = FlashCardsRealm.realm) {
        self.realm = realm
    }

    /// Maps from Domain (Deck) to Realm-based repository entity (DeckRealmEntity)
    /// we just find the Realm object, no need to map anything
    public func map(_ inData: InType) -> OutType {
        
        let cards = CardToCardRealmEntityMapper().map(cards: inData.cards as! [FlashCard])
                
        if let foundDeck = realm?.objects(DeckEntityRealmImpl.self).filter("title == %@ AND deckDescription == %@", inData.title, inData.description).first {
            return foundDeck
        }

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
    
    private let realm: Realm?
    
    public init(realm: Realm? = FlashCardsRealm.realm) {
        self.realm = realm
    }
    
    public func map(_ inData: InType) -> OutType {
        if let foundCard = realm?.objects(CardEntityRealmImpl.self).filter("title == %@ AND backText == %@", inData.title, inData.description).first {
            return foundCard
        }
        
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
