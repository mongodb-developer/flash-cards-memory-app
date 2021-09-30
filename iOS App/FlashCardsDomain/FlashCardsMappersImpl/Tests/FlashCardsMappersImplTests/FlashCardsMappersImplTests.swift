import XCTest
@testable import FlashCardsMappersImpl
import FlashCardsModelsImpl
import FlashCardsDataEntitiesImpl
import Foundation

final class FlashCardsMappersImplTests: XCTestCase {
    func test_Given1DeckEntity_When_Mapped_Then_Gets1Deck() throws {
        // Given
        let deckEntity = DeckEntityImpl(title: "Entity title",
                                        description: "Entity Description",
                                        icon: "",
                                        creationDate: Date(),
                                        lastUpdateDate: Date(),
                                        cards: [])
        
        let mapper = DeckEntityToDeckMapperImpl()
        
        // When
        let mappedDecks = mapper.map(deckEntities: [deckEntity])
        
        // Then
        let deck = mappedDecks.first!
        
        XCTAssertEqual(deck.title, deckEntity.title)
        XCTAssertEqual(deck.description, deckEntity.deckDescription)
    }
}
