import Foundation
import FlashCardsUseCases
import FlashCardsModels
import FlashCardsRepositories
import FlashCardsRepositoriesImpl
import FlashCardsDataEntities

public struct GetAllDecksUseCaseMock: GetAllDecksUseCase {
    public var businessRules: [BusinessRule]? = nil
    private let decksRepository: DeckRepository
    
    public init(decksRepository: DeckRepository = DeckRepositoryImpl()) {
        self.decksRepository = decksRepository
    }
    
    public func execute(data: ()? = nil, completion: @escaping (UseCaseResult<Array<Deck>>) -> Void) {
        decksRepository.getAllDecks { (response: RepositoryResponse<[DeckEntity]>) in
            let decks: [Deck] = DeckEntityToDeckMapper.map(decks: response.data)
            
            completion(UseCaseResult(value: decks, code: .Success))
        }
        
    }
}
