import XCTest
@testable import FlashCardsUseCases
@testable import FlashCardsModels


struct GetAllDecksUseCaseEmptyImpl: GetAllDecksUseCase {
    var businessRules: [BusinessRule]? = nil
    
    func execute(data: Void? = nil, completion: (UseCaseResult<[Deck]>) -> Void) {
        completion(UseCaseResult(value: [], code: .Success) )
        
    }
}


final class FlashCardsUseCasesTests: XCTestCase {
    func testEmptyImplementationReturnsEmptyArray() throws {
        let useCase = GetAllDecksUseCaseEmptyImpl()
        
        useCase.execute() { (r: UseCaseResult<[Deck]>) in
            XCTAssert(r.value.count == 0)
        }
    }
    
    func testImplementationWithOneDeckReturnsArrayWithOneDeck() throws {
        let useCase = GetAllDecksUseCaseWithOneDeckImpl()
        
        useCase.execute() { (r: UseCaseResult<[Deck]>) in
            XCTAssert(r.value.count == 1)
            XCTAssert(r.value[0].title == "My Deck")
        }
 
    }
}

struct FlashCardDeck: Deck {
    let cards: [Card]
    
    let title: String
    let description: String
    let icon: String
    let creationDate: Date
    let lastUpdateDate: Date
}

struct GetAllDecksUseCaseWithOneDeckImpl: GetAllDecksUseCase {
    var businessRules: [BusinessRule]? = nil
    
    func execute(data: Void? = nil, completion: (UseCaseResult<[Deck]>) -> Void) {
        let deck = FlashCardDeck(cards: [], title: "My Deck", description: "Some desc", icon: "", creationDate: Date(), lastUpdateDate: Date())
        completion(UseCaseResult(value: [deck], code: .Success))
        
    }
}


struct AddDeckUseCaseImpl: AddDeckUseCase {
    var businessRules: [BusinessRule]? = nil

    func execute(data: Deck?, completion: (UseCaseResult<Bool>) -> Void) {
        // save data
        completion(UseCaseResult(value: true, code: .Success))
    }
}
