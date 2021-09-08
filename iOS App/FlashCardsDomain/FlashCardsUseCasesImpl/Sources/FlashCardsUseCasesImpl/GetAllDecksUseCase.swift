import Foundation
import FlashCardsUseCases
import FlashCardsModels
import FlashCardsRepositories
import FlashCardsRepositoriesImpl
import FlashCardsDataEntities

public struct GetAllDecksUseCaseImpl<T: DeckRepository>: GetAllDecksUseCase {
    public var businessRules: [BusinessRule]? = nil
    private let decksRepository: T
    
    public init(decksRepository: T) {
        self.decksRepository = decksRepository
    }
    
    public func execute(data: ()? = nil, completion: @escaping (UseCaseResult<Array<Deck>>) -> Void) {
        decksRepository.getAllDecks { (response: RepositoryResponse<[T.DeckEntityType]>) in
            
            let decks: [Deck]
            if let deckEntities = response.data as? [DeckEntity] {
                decks = DeckEntityToDeckMapper().map(deckEntities: deckEntities)
            } else {
                decks = []
            }
            
            completion(UseCaseResult(value: decks, code: .Success))
        }
        
    }
}
