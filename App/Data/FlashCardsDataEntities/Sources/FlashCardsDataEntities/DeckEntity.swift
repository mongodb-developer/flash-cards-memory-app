import Foundation

public protocol DeckEntity {
    var title: String { get }
    var deckDescription: String { get }
    var icon: String { get }
    var creationDate: Date { get }
    var lastUpdateDate: Date { get }
    var cards: [CardEntity] { get }
}
