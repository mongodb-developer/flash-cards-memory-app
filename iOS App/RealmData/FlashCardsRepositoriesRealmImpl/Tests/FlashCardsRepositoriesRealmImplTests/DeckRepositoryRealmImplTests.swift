import XCTest
@testable import FlashCardsRepositoriesRealmImpl
import FlashCardsRepositories
import FlashCardsDataEntities
import RealmSwift
import FlashCardsDataEntitiesRealmImpl

final class DeckRepositoryRealmImplTests: XCTestCase {
    
    func test_Given_NilRealm_When_ListAllDecks_Then_ReturnsPreconditionError() throws {
        
        var end = false

        // given
        let repository = DeckRepositoryRealmImpl(realm: nil)
        
        // when
        repository.getAll { (response: RepositoryResponse<[DeckEntityRealmImpl]>) in
            
            // then
            XCTAssertNotNil(response.data)
            XCTAssertEqual(0, response.data.count)
            end = true
        }
        
        while !end {
            // wait
        }
    }
    
    
    func test_Given_EmptyRealm_When_ListAllDecks_Then_ReturnsEmptyDecks() throws {
        
        var end = false

        // given
        let repository = DeckRepositoryRealmImpl(realm: initTestRealm()!)
        clearRealm() // empty Realm
        
        // when
        repository.getAll { (response: RepositoryResponse<[DeckEntityRealmImpl]>) in
            
            // then
            XCTAssertNotNil(response.data)
            XCTAssertEqual(0, response.data.count)
            end = true
        }
        
        while !end {
            // wait
        }
    }
    
    func test_Given_RealmWith10Decks_When_ListAllDecks_Then_Returns10Decks() throws {
        
        var end = false

        // given
        let repository = DeckRepositoryRealmImpl(realm: initTestRealm()!)
        clearRealm()
        insertDecks(numOfDecks: 10)
        
        // when
        repository.getAll { (response: RepositoryResponse<[DeckEntityRealmImpl]>) in
            
            // then
            XCTAssertNotNil(response.data)
            XCTAssertEqual(10, response.data.count)
            XCTAssertEqual("Deck Title 0", response.data[0].title)
            XCTAssertEqual("Deck Description 0", response.data[0].deckDescription)

            end = true
        }
        
        while !end {
            // wait
        }
    }
    
    func test_Given_EmptyRealm_When_InsertingDecks_Then_DeckIsInserted() throws {
        // given
        var end = false
        let repository = DeckRepositoryRealmImpl(realm: initTestRealm()!)
        
        let deck = DeckEntityRealmImpl(title: "A Deck", description: "Some desc", icon: "icon here", creationDate: Date(), lastUpdateDate: Date(), cards: [])
        
        repository.add(deck) { (response: RepositoryResponse<Bool>) in
            
            XCTAssertTrue(response.data)
            end = true
        }
        
        
        while !end {
            // wait
        }
    }

    
    func test_Given_RealmWith10Decks_When_DeleteOneDeck_Then_9DecksAreLeft() throws {
        
        var end = false

        // given
        let repository = DeckRepositoryRealmImpl(realm: initTestRealm()!)
        clearRealm()
        insertDecks(numOfDecks: 10)
        
        repository.getAll { (response: RepositoryResponse<[DeckEntityRealmImpl]>) in
            
            XCTAssertNotNil(response.data)
            XCTAssertEqual(10, response.data.count)
            
            // when
            
            repository.delete(response.data[0]) { (deleteResponse: RepositoryResponse<Bool>) in
                XCTAssertTrue(deleteResponse.data)
            
                // then

                repository.getAll { (response: RepositoryResponse<[DeckEntityRealmImpl]>) in
                    
                    XCTAssertNotNil(response.data)
                    XCTAssertEqual(9, response.data.count)
                
                    end = true
                }
            }
        }
        
        while !end {
            // wait
        }
    }
}



