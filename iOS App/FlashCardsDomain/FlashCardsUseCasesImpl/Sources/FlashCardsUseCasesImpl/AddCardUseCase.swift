import Foundation
import FlashCardsUseCases
import FlashCardsModels
import FlashCardsRepositories
import FlashCardsDataEntities

public struct AddCardUseCaseImpl<T: CardRepository, DeckToEntityMapper: Mapper, CardToEntityMapper: Mapper> :AddCardUseCase {
    public var businessRules: [BusinessRule]? = nil
    private let cardsRepository: T
    private let deck: Deck
    private let deckToDeckEntityMapper: DeckToEntityMapper
    private let cardToCardEntityMapper: CardToEntityMapper

    public init(deck: Deck, cardsRepository: T, deckToDeckEntityMapper: DeckToEntityMapper, cardToCardEntityMapper: CardToEntityMapper) {
        self.deck = deck
        self.cardsRepository = cardsRepository
        self.deckToDeckEntityMapper = deckToDeckEntityMapper
        self.cardToCardEntityMapper = cardToCardEntityMapper
    }
    
    public func execute(data: Card? = nil, completion: @escaping (UseCaseResult<Bool>) -> Void) {
        guard let data = data,
              let cardEntity = cardToCardEntityMapper.map(data as! CardToEntityMapper.InType) as? T.EntityType
//              let deckEntity = deckToDeckEntityMapper.map(self.deck as! DeckToEntityMapper.InType) as? T.EntityType
        else {
            completion(UseCaseResult<Bool>(value: false, code: .GeneralError))
            return
        }
        
        cardsRepository.add(cardEntity) { (response: RepositoryResponse<Bool>) in
            completion(UseCaseResult<Bool>(value: true, code: .Success))
        }
    }
}
