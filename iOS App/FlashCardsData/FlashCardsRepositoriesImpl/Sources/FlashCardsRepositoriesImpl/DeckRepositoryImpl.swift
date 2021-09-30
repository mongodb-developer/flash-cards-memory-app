import Foundation
import FlashCardsRepositories
import FlashCardsDataEntities
import FlashCardsDataEntitiesImpl
import FlashCardsPersistence
import FlashCardsNetwork

public struct DeckRepositoryImpl: DeckRepository {
    
    public typealias EntityType = DeckEntity

    public init() {
        
    }
    
    public func add(_ entity: DeckEntity, completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        completion(RepositoryResponse<Bool>(code: 200, message: "Inserted", data: true))
    }
    
    public func getAll(completion: @escaping (RepositoryResponse<[DeckEntity]>) -> Void) {
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
    
    public func delete(_ entity: DeckEntity, completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        completion(RepositoryResponse<Bool>(code: 200, message: "Inserted", data: true))
    }
    
    public func deleteAll(completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        completion(RepositoryResponse<Bool>(code: 200, message: "Inserted", data: true))
    }
    
    public func update(_ entity: DeckEntity, completion: @escaping (RepositoryResponse<DeckEntity>) -> Void) {
        
    }
}
