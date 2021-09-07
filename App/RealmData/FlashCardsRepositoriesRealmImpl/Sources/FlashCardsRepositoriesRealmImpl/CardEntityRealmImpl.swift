//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 6/9/21.
//

import Foundation
import Realm
import FlashCardsDataEntities
import RealmSwift

public class CardEntityRealmImpl: Object, CardEntity {
    
    @Persisted
    public var title: String
    
    @Persisted
    public var backText: String
    
    @Persisted
    public var icon: String
    
    @Persisted
    public var creationDate: Date
    
    @Persisted
    public var lastUpdateDate: Date
    
    public convenience init(title: String,
                description: String,
                icon: String,
                creationDate: Date,
                lastUpdateDate: Date) {
        self.init()
        
        self.title = title
        self.backText = description
        self.icon = icon
        self.creationDate = creationDate
        self.lastUpdateDate = lastUpdateDate
    }
    
    public convenience init(cardEntity: CardEntity) {
        self.init()
        
        self.title = cardEntity.title
        self.backText = cardEntity.backText
        self.icon = cardEntity.icon
        self.creationDate = cardEntity.creationDate
        self.lastUpdateDate = cardEntity.lastUpdateDate
    }
}
