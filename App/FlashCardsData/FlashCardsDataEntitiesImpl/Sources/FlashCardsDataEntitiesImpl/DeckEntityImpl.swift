import Foundation
import FlashCardsDataEntities

public struct DeckEntityImpl: DeckEntity {    
    public let title: String
    public let deckDescription: String
    public let icon: String
    public let creationDate: Date
    public let lastUpdateDate: Date
    public let cards: [CardEntity]

    public init(title: String,
                description: String,
                icon: String,
                creationDate: Date,
                lastUpdateDate: Date,
                cards: [CardEntityImpl]) {
        self.title = title
        self.deckDescription = description
        self.icon = icon
        self.creationDate = creationDate
        self.lastUpdateDate = lastUpdateDate
        self.cards = cards
    }
}
