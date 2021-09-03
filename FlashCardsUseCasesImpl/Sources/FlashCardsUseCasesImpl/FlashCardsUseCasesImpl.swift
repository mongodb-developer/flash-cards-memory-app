import Foundation
import FlashCardsUseCases
import FlashCardsModels

public struct GetAllDecksUseCaseMock: GetAllDecksUseCase {
    public var businessRules: [BusinessRule]? = nil
   
    public init() {
        
    }
    
    public func execute(data: ()? = nil, completion: (UseCaseResult<Array<Deck>>) -> Void) {
        let returnValue = [
            FlashCardDeck(title: "Deck 1",
                          description: "Deck 1 desc",
                          icon: "arrow.down.square",
                          creationDate: Date(),
                          lastUpdateDate: Date(),
                          cards: [FlashCard(title: "Good Morning", description: "おはようございます", icon: "", creationDate: Date(), lastUpdateDate: Date())]),
            FlashCardDeck(title: "Deck 2",
                          description: "Deck 2 desc",
                          icon: "apps.ipad.landscape",
                          creationDate: Date(),
                          lastUpdateDate: Date(),
                          cards: []),
            FlashCardDeck(title: "Deck 3",
                          description: "Deck 3 desc",
                          icon: "archivebox.fill",
                          creationDate: Date(),
                          lastUpdateDate: Date(),
                          cards: []),
            FlashCardDeck(title: "Deck 4",
                          description: "Deck 4 desc",
                          icon: "arrow.down.forward.circle",
                          creationDate: Date(),
                          lastUpdateDate: Date(),
                          cards: [])
        ]
        
        completion(UseCaseResult(value: returnValue, code: .Success))
    }
}
