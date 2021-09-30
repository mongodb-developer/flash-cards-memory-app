import Foundation
import FlashCardsUseCases
import FlashCardsModels
import FlashCardsRepositories
import FlashCardsDataEntities

public struct AddDeckUseCaseImpl<T: DeckRepository, DeckToEntityMapper: Mapper>: AddDeckUseCase {
    public var businessRules: [BusinessRule]? = nil
    private let decksRepository: T
    private let deckToDeckEntityMapper: DeckToEntityMapper

    public init(decksRepository: T, deckToDeckEntityMapper: DeckToEntityMapper) {
        self.decksRepository = decksRepository
        self.deckToDeckEntityMapper = deckToDeckEntityMapper
    }
    
    public func execute(data: Deck? = nil, completion: @escaping (UseCaseResult<Bool>) -> Void) {
        guard let data = data,
              let deckEntity = deckToDeckEntityMapper.map(data as! DeckToEntityMapper.InType) as? T.EntityType
        else {
            completion(UseCaseResult<Bool>(value: false, code: .GeneralError))
            return
        }
        decksRepository.add(deckEntity) { (response: RepositoryResponse<Bool>) in
            completion(UseCaseResult<Bool>(value: true, code: .Success))
        }
    }
}
