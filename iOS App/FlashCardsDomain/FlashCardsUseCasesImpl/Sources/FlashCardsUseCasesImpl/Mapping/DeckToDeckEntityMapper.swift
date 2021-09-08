import Foundation
import FlashCardsNetwork
import FlashCardsDataEntities
import FlashCardsDataEntitiesImpl
import FlashCardsModels
import FlashCardsUseCases

// DeckEntity --> Deck
public struct DeckToDeckEntityMapper: Mapper {
    
    public typealias InType = Deck
    public typealias OutType = DeckEntity
    
    public init() {}

    public func map(inData: InType) -> OutType {
        
        let cards = FlashCardToCardEntityMapper().map(cards: inData.cards)
        
        let deckEntity = DeckEntityImpl(title: inData.title,
                                  description: inData.description,
                                  icon: inData.icon,
                                  creationDate: inData.creationDate,
                                  lastUpdateDate: inData.lastUpdateDate,
                                  cards: cards)
        return deckEntity
    }
    
    public func map(deckEntities: [Deck]) -> [DeckEntity] {
        var returnDecks: [DeckEntityImpl] = []
        
        for deckEntity in deckEntities {
            if let entity = map(inData: deckEntity) as? DeckEntityImpl {
                returnDecks.append(entity)
            }
        }
        
        return returnDecks
    }
}

public struct FlashCardToCardEntityMapper: Mapper {
    
    public typealias InType = Card
    public typealias OutType = CardEntity
    
    public init() {}
    
    public func map(inData: InType) -> OutType {
        let cardEntity = CardEntityImpl(title: inData.title,
                                        description: inData.description,
                                        icon: inData.icon,
                                        creationDate: inData.creationDate,
                                        lastUpdateDate: inData.lastUpdateDate)
        
        return cardEntity
    
    }

    public func map(cards: [Card]) -> [CardEntity] {
        var returnCards: [CardEntityImpl] = []
        
        for card in cards {
            if let card = map(inData: card) as? CardEntityImpl {
                returnCards.append(card)
            }
        }
        
        return returnCards
    }
}
