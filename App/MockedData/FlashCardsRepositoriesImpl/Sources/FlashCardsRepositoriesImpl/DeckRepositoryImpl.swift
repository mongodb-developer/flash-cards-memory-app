import Foundation
import FlashCardsRepositories
import FlashCardsDataEntities
import FlashCardsDataEntitiesImpl
import FlashCardsPersistence
import FlashCardsNetwork

public struct DeckRepositoryImpl: DeckRepository {
    
    public init() {
        
    }
    
    public func getAllDecks(completion: @escaping (RepositoryResponse<[DeckEntity]>) -> Void) {
        
        // check local cache first
        
        FlashCardsPersistence.getAllDecks { (decks: [DeckEntity]) in
            
            // if something is found in the cache, return it
            if !decks.isEmpty {
                completion(RepositoryResponse(code: 200, message: "", data: decks))
                return
            }
            
            // else hit the network
            FlashCardsAPI.DeckAPI().getAllDecks { (response: NetworkRespose<[DeckNetworkEntity]>) in
                let networkDeckEntities = response.data
                
                let networkDecks: [DeckEntity] = DeckNetworkEntityToDeckEntityMapper.map(networkEntities: networkDeckEntities)
                
                completion(RepositoryResponse(code: 200, message: "", data: networkDecks))
            }
        }
    }
    
    public func deleteDeck(_ deck: DeckEntity, completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        
    }
    
    public func deleteAllDecks(completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        
    }
    
    
    public func updateDeck(_ deck: DeckEntity, completion: @escaping (RepositoryResponse<DeckEntity>) -> Void) {
        
    }
    
    public func addDeck(_ deck: DeckEntity, completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        
    }
    
}
