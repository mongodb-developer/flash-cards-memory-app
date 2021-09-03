import FlashCardsUseCases
import FlashCardsModels

public struct Mock_GetAllDecksUseCaseEmptyImpl: GetAllDecksUseCase {
    public var businessRules: [BusinessRule]? = nil
    
    public func execute(data: Void? = nil, completion: (UseCaseResult<[Deck]>) -> Void) {
        completion(UseCaseResult(value: [], code: .Success) )
        
    }
}
