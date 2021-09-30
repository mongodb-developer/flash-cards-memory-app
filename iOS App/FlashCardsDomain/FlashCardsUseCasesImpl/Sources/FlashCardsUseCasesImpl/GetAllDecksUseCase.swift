import Foundation
import FlashCardsUseCases
import FlashCardsModels
import FlashCardsRepositories
import FlashCardsDataEntities

public struct GetAllDecksUseCaseImpl<T: DeckRepository, S: Mapper>: GetAllDecksUseCase {
    private let decksRepository: T
    private let deckEntityToDeckMapper: S
    
    public var businessRules: [BusinessRule]? = nil
    
    public init(decksRepository: T, deckEntityToDeckMapper: S) {
        self.decksRepository = decksRepository
        self.deckEntityToDeckMapper = deckEntityToDeckMapper
    }
    
    public func execute(data: ()? = nil, completion: @escaping (UseCaseResult<Array<Deck>>) -> Void) {
        decksRepository.getAll { (response: RepositoryResponse<[T.EntityType]>) in
            
            let decks: [Deck]
            if let deckEntities = response.data as? [DeckEntity] {
//                decks = deckEntityToDeckMapper.map(inData: deckEntities)
                var returnDecks: [Deck] = []
                
                for deckEntity in deckEntities {
                    let deck = deckEntityToDeckMapper.map(deckEntity as! S.InType)
                    returnDecks.append(deck as! Deck)
                }
                
                decks = returnDecks
            } else {
                decks = []
            }
            
            completion(UseCaseResult(value: decks, code: .Success))
        }
        
    }
}
