//
//  File.swift
//  
//
//  Created by Diego Freniche Brito on 29/9/21.
//

import XCTest
@testable import FlashCardsRepositoriesRealmImpl
import FlashCardsRepositories
import FlashCardsDataEntities
import RealmSwift
import FlashCardsDataEntitiesRealmImpl

final class CardRepositoryRealmImplTests: XCTestCase {
    
    func test_Given_EmptyRealm_When_InsertingADeckWithCards_Then_DeckIsInsertedWithThoseCards() throws {
        // given
        var end = false

        let deck = DeckEntityRealmImpl(title: "A Deck", description: "Some desc", icon: "icon here", creationDate: Date(), lastUpdateDate: Date(), cards: [])

        let repository = CardRepositoryRealmImpl(deck: deck, realm: initTestRealm()!)

        let card = CardEntityRealmImpl(title: "Card 1", description: "Desc Card 1", icon: "Icon 1", creationDate: Date(), lastUpdateDate: Date())
        repository.add(card) { (response: RepositoryResponse<Bool>) in
            XCTAssertTrue(response.data)
            XCTAssertEqual(1, deck.cards.count)
            XCTAssertEqual(1, deck.realmCards.count)
            XCTAssertEqual("Card 1", deck.realmCards[0].title)

            end = true
        }

        while !end {
            // wait
        }
    }
}
