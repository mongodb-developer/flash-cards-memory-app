import Foundation
import FlashCardsUseCases
import FlashCardsModels
import FlashCardsRepositories
import FlashCardsRepositoriesImpl
import FlashCardsDataEntities

public struct AddCardUseCaseImpl<T: DeckRepository, DeckToEntityMapper: Mapper, CardToEntityMapper: Mapper> :AddCardUseCase {
    public var businessRules: [BusinessRule]? = nil
    private let decksRepository: T
    private let deck: Deck
    private let deckToDeckEntityMapper: DeckToEntityMapper
    private let cardToCardEntityMapper: CardToEntityMapper

    public init(deck: Deck, decksRepository: T, deckToDeckEntityMapper: DeckToEntityMapper, cardToCardEntityMapper: CardToEntityMapper) {
        self.deck = deck
        self.decksRepository = decksRepository
        self.deckToDeckEntityMapper = deckToDeckEntityMapper
        self.cardToCardEntityMapper = cardToCardEntityMapper
    }
    
    public func execute(data: Card? = nil, completion: @escaping (UseCaseResult<Bool>) -> Void) {
        guard let data = data,
              let cardEntity = cardToCardEntityMapper.map(inData: data as! CardToEntityMapper.InType) as? T.CardEntityType,
              let deckEntity = deckToDeckEntityMapper.map(inData: self.deck as! DeckToEntityMapper.InType) as? T.DeckEntityType
        else {
            completion(UseCaseResult<Bool>(value: false, code: .GeneralError))
            return
        }
        
        decksRepository.addCard(cardEntity, deck: deckEntity) { (response: RepositoryResponse<Bool>) in
            completion(UseCaseResult<Bool>(value: true, code: .Success))
        }
    }
}
