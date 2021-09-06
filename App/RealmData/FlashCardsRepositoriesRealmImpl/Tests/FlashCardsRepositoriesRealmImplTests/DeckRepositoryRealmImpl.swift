import XCTest
@testable import FlashCardsRepositoriesRealmImpl
import FlashCardsRepositories
import FlashCardsDataEntities
import RealmSwift

final class DeckRepositoryRealmImplTests: XCTestCase {
    
    func test_Given_NilRealm_When_ListAllDecks_Then_ReturnsPreconditionError() throws {
        
        var end = false

        // given
        let repository = DeckRepositoryRealmImpl(realm: nil)
        
        // when
        repository.getAllDecks { (response: RepositoryResponse<[DeckEntity]>) in
            
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
        repository.getAllDecks { (response: RepositoryResponse<[DeckEntity]>) in
            
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
        repository.getAllDecks { (response: RepositoryResponse<[DeckEntity]>) in
            
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
        
        repository.addDeck(deck) { (response: RepositoryResponse<Bool>) in
            
            XCTAssertTrue(response.data)
            end = true
        }
        
        
        while !end {
            // wait
        }
    }
}

// MARK: - Testing Utilities
extension DeckRepositoryRealmImplTests {
    
    // clears the Realm
    private func clearRealm() {
        let realm = initTestRealm()

        do {
            realm?.beginWrite()
            realm?.deleteAll()
            try realm?.commitWrite()
        } catch {
           fatalError("Error writing: \(error)")
        }
    }
    
    // creates an in memory Realm, perfect for testing!
    private func initTestRealm() -> Realm? {
        do {
            let configuration = Realm.Configuration(fileURL: nil,
                                                    inMemoryIdentifier: "inMemory",
                                                    syncConfiguration: nil, encryptionKey: nil,
                                                    readOnly: false, schemaVersion: 1,
                                                    migrationBlock: nil,
                                                    deleteRealmIfMigrationNeeded: true,
                                                    shouldCompactOnLaunch: nil, objectTypes: nil)
            let realm = try Realm(configuration: configuration, queue: .main)
            return realm
        } catch {
            fatalError("Something bad happened: \(error)")
        }
    }
    
    private func insertDeck(title: String, description: String, icon: String) {
        let repository = DeckRepositoryRealmImpl(realm: initTestRealm()!)

        let deck = DeckEntityRealmImpl(title: title, description: description, icon: icon, creationDate: Date(), lastUpdateDate: Date(), cards: [])
        
        repository.addDeck(deck) { (response: RepositoryResponse<Bool>) in
            // ignored, hope insert is OK, otherwise there are tests to catch it
        }
    }
    
    private func insertDecks(numOfDecks: Int) {
        for i in 0 ..< numOfDecks {
            insertDeck(title: "Deck Title \(i)", description: "Deck Description \(i)", icon: "Icon \(i)")
        }
    }
}
