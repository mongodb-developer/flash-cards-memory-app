import Foundation
import FlashCardsUseCases
import FlashCardsModels
import FlashCardsRepositories
import FlashCardsRepositoriesImpl
import FlashCardsDataEntities

public struct DeleteDeckUseCaseImpl<T: DeckRepository>: AddDeckUseCase {
    public var businessRules: [BusinessRule]? = nil
    private let decksRepository: T
    
    public init(decksRepository: T) {
        self.decksRepository = decksRepository
    }
    
    public func execute(data: Deck? = nil, completion: @escaping (UseCaseResult<Bool>) -> Void) {
        guard let data = data,
              let deckEntity = DeckToDeckEntityMapper().map(inData: data) as? T.DeckEntityType
        else {
            completion(UseCaseResult<Bool>(value: false, code: .GeneralError))
            return
        }
        decksRepository.deleteDeck(deckEntity) { (response: RepositoryResponse<Bool>) in
            completion(UseCaseResult<Bool>(value: true, code: .Success))
        }
    }
}
