import FlashCardsDataEntities

public protocol DeckRepository {
    
    /// Reads all Decks from the persistence layer
    ///
    /// - parameter ``completion``: closure to return all Decks
    /// - returns: an array of ``DeckEntity``  (can be empty)
    func getAllDecks(completion: @escaping (RepositoryResponse<[DeckEntity]>) -> Void)
    
    /// Deletes a Deck from the persistence layer
    ///
    /// - parameter ``completion``: closure to return success of failure
    /// - returns: true is successful
    func deleteDeck(_ deck: DeckEntity, completion: @escaping (RepositoryResponse<Bool>) -> Void)
    
    func deleteAllDecks(completion: @escaping (RepositoryResponse<Bool>) -> Void)

    func updateDeck(_ deck: DeckEntity, completion: @escaping (RepositoryResponse<DeckEntity>) -> Void)
    func addDeck(_ deck: DeckEntity, completion: @escaping (RepositoryResponse<Bool>) -> Void)
}
