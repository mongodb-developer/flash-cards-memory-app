import XCTest
@testable import FlashCardsNetwork

final class FlashCardsNetworkTests: XCTestCase {
    func test_Given_CorrectURL_Get_NonEmpty_FlashCards() throws {
        var end = false
        
        FlashCardsAPI.DeckAPI().getAllDecks { (response: NetworkRespose<[DeckNetworkEntity]>) in
            let decks = response.data
            XCTAssertTrue(decks.count > 0)
            XCTAssertEqual(1, decks.count)
            XCTAssertEqual(decks[0].title, "Japanese")
            end = true
        }
        
        while (!end) {
           // wait for above thread to finish
        }
    }
    
    func test_Given_MalformedURL_Get_Error_FlashCards() throws {
        var end = false
        
        FlashCardsAPI.DeckAPI().getAllDecks("error here") { (response: NetworkRespose<[DeckNetworkEntity]>) in
            let decks = response.data
            XCTAssertTrue(decks.count == 0)
            XCTAssertTrue(response.code == NetworkErrors.malformedURL)
            end = true
        }
        
        while (!end) {
            // wait for above thread to finish
        }
    }
}
