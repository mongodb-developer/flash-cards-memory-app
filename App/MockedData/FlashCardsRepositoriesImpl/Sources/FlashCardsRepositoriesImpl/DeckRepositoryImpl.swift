import Foundation
import FlashCardsRepositories
import FlashCardsDataEntities
import FlashCardsDataEntitiesImpl

public struct DeckRepositoryImpl: DeckRepository {
    public func getAllDecks(completion: ([DeckEntity]) -> Void) {
        let returnValue = [
            DeckEntityImpl(title: "Deck 1",
                          description: "Deck 1 desc",
                          icon: "arrow.down.square",
                          creationDate: Date(),
                          lastUpdateDate: Date(),
                          cards: [CardEntityImpl(title: "Good Morning", description: "おはようございます", icon: "", creationDate: Date(), lastUpdateDate: Date())]),
            DeckEntityImpl(title: "Deck 2",
                          description: "Deck 2 desc",
                          icon: "apps.ipad.landscape",
                          creationDate: Date(),
                          lastUpdateDate: Date(),
                          cards: []),
            DeckEntityImpl(title: "Deck 3",
                          description: "Deck 3 desc",
                          icon: "archivebox.fill",
                          creationDate: Date(),
                          lastUpdateDate: Date(),
                          cards: []),
            DeckEntityImpl(title: "Deck 4",
                          description: "Deck 4 desc",
                          icon: "arrow.down.forward.circle",
                          creationDate: Date(),
                          lastUpdateDate: Date(),
                          cards: [])
        ]
        
//        completion(UseCaseResult(value: returnValue, code: .Success))
        completion(returnValue)
    }
    
    public func deleteDeck(_ deck: DeckEntity) {
        
    }
    
    public func updateDeck(_ deck: DeckEntity) {
        
    }
    
    public func addDeck(_ deck: DeckEntity) {
        
    }
    
    
}
