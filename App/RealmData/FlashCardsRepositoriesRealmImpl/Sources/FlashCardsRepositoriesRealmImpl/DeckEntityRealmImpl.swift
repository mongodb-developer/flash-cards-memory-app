//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 5/9/21.
//

import Foundation
import Realm
import FlashCardsDataEntities
import RealmSwift

public class DeckEntityRealmImpl: Object, DeckEntity {
    
    @Persisted
    public var title: String
    
    @Persisted
    public var deckDescription: String
    
    @Persisted
    public var icon: String
    
    @Persisted
    public var creationDate: Date
    
    @Persisted
    public var lastUpdateDate: Date
    
    @Persisted
    public var realmCards: List<CardEntityRealmImpl>
    
    public var cards: [CardEntity] = []
    
    public convenience init(title: String,
                description: String,
                icon: String,
                creationDate: Date,
                lastUpdateDate: Date,
                cards: [CardEntityRealmImpl]) {
        self.init()
        
        self.title = title
        self.deckDescription = description
        self.icon = icon
        self.creationDate = creationDate
        self.lastUpdateDate = lastUpdateDate
        self.cards = cards
    }
}