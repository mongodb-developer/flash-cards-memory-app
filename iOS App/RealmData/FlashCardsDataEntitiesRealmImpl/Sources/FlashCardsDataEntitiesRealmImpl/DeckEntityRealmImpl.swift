import Foundation
import Realm
import FlashCardsDataEntities
import RealmSwift

/// DeckEntity implemented using Realm
public class DeckEntityRealmImpl: Object, DeckEntity {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var _partition: String = "partitionKey"

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
    
    public var cards: [CardEntity] {
        get {
            var cards: [CardEntity] = []
            for cardEntityRealm in realmCards {
                cards.append(CardEntityRealmImpl(title: cardEntityRealm.title, description: cardEntityRealm.backText, icon: cardEntityRealm.icon, creationDate: cardEntityRealm.creationDate, lastUpdateDate: cardEntityRealm.lastUpdateDate))
            }
            return cards
        }
        
//        set {
//            for cardEntity in newValue {
//                realmCards.append(CardEntityRealmImpl(cardEntity: cardEntity))
//            }
//        }
    }
    
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
        addCards(cards)
    }
    
    public convenience init(deckEntity: DeckEntity) {
        self.init()
        
        self.title = deckEntity.title
        self.deckDescription = deckEntity.deckDescription
        self.icon = deckEntity.icon
        self.creationDate = deckEntity.creationDate
        self.lastUpdateDate = deckEntity.lastUpdateDate
        
        var cards: [CardEntityRealmImpl] = []
        for cardEntity in deckEntity.cards {
            cards.append(CardEntityRealmImpl(title: cardEntity.title,
                                             description: cardEntity.backText,
                                             icon: cardEntity.icon,
                                             creationDate: cardEntity.creationDate,
                                             lastUpdateDate: cardEntity.lastUpdateDate))
        }
        addCards(cards)
    }
    
    public func addCards(_ cards: [CardEntityRealmImpl]) {
        let _ = cards.map { addCard($0) }
    }
    
    public func addCard(_ card: CardEntityRealmImpl) {
        realmCards.append(card)
    }
}
