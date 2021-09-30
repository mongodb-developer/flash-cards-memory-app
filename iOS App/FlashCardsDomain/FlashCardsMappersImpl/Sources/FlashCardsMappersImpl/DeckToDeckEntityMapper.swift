import Foundation
import FlashCardsDataEntities
import FlashCardsModels
//import FlashCardsMappers
import FlashCardsDataEntitiesImpl
import FlashCardsModelsImpl

public struct DeckToDeckEntityMapperImpl: Mapper {

    public typealias InType = FlashCardDeck
    public typealias OutType = DeckEntityImpl
    
    public init() {}

    public func map(_ inData: InType) -> OutType {
        
        let deckCards: [CardEntityImpl]
        if let cards = inData.cards as? [FlashCard] {
            deckCards = FlashCardToCardEntityMapperImpl().map(cards: cards)
        } else {
            deckCards = []
        }
        
        let deckEntity = DeckEntityImpl(title: inData.title,
                                  description: inData.description,
                                  icon: inData.icon,
                                  creationDate: inData.creationDate,
                                  lastUpdateDate: inData.lastUpdateDate,
                                  cards: deckCards)
        return deckEntity
    }
    
    public func map(decks: [FlashCardDeck]) -> [DeckEntityImpl] {
        var returnDecks: [DeckEntityImpl] = []
        
        for deck in decks {
            let deckEntity = map(deck)
            returnDecks.append(deckEntity)
        }
        
        return returnDecks
    }
}



public struct FlashCardToCardEntityMapperImpl: Mapper {
    
    public typealias InType = FlashCard
    public typealias OutType = CardEntityImpl
    
    public init() {}
    
    public func map(_ inData: InType) -> OutType {
        let cardEntity = CardEntityImpl(title: inData.title,
                                        description: inData.description,
                                        icon: inData.icon,
                                        creationDate: inData.creationDate,
                                        lastUpdateDate: inData.lastUpdateDate)
        
        return cardEntity
    
    }

    public func map(cards: [FlashCard]) -> [CardEntityImpl] {
        var returnCards: [CardEntityImpl] = []
        
        for card in cards {
            let cardEntity = map(card)
            returnCards.append(cardEntity)
        }
        
        return returnCards
    }
}
