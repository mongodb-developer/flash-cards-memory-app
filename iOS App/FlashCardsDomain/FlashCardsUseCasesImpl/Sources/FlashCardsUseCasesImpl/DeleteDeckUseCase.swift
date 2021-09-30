import Foundation
import FlashCardsUseCases
import FlashCardsModels
import FlashCardsRepositories
import FlashCardsDataEntities

public struct DeleteDeckUseCaseImpl<T: DeckRepository, S: Mapper>: DeleteDeckUseCase {
    public var businessRules: [BusinessRule]? = nil
    private let decksRepository: T
    private let deckToDeckEntityMapper: S

    public init(decksRepository: T, deckToDeckEntityMapper: S) {
        self.decksRepository = decksRepository
        self.deckToDeckEntityMapper = deckToDeckEntityMapper
    }
    
    public func execute(data: Deck? = nil, completion: @escaping (UseCaseResult<Bool>) -> Void) {
        guard let data = data,
              let deckEntity = deckToDeckEntityMapper.map(data as! S.InType) as? T.EntityType
        else {
            completion(UseCaseResult<Bool>(value: false, code: .GeneralError))
            return
        }
        decksRepository.delete(deckEntity) { (response: RepositoryResponse<Bool>) in
            completion(UseCaseResult<Bool>(value: true, code: .Success))
        }
    }
}
