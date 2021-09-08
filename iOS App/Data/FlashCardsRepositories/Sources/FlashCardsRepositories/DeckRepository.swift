public protocol DeckRepository {
    associatedtype DeckEntityType
    associatedtype CardEntityType
    
    /// Reads all Decks from the persistence layer
    ///
    /// - parameter ``completion``: closure to return all Decks
    /// - returns: an array of ``DeckEntity``  (can be empty)
    func getAllDecks(completion: @escaping (RepositoryResponse<[DeckEntityType]>) -> Void)
    
    /// Deletes a Deck from the persistence layer
    ///
    /// - parameter ``completion``: closure to return success of failure
    /// - returns: true is successful
    func deleteDeck(_ deck: DeckEntityType, completion: @escaping (RepositoryResponse<Bool>) -> Void)
    
    func deleteAllDecks(completion: @escaping (RepositoryResponse<Bool>) -> Void)

    func updateDeck(_ deck: DeckEntityType, completion: @escaping (RepositoryResponse<DeckEntityType>) -> Void)
    func addDeck(_ deck: DeckEntityType, completion: @escaping (RepositoryResponse<Bool>) -> Void)
    
    func addCard(_ card: CardEntityType, deck: DeckEntityType, completion: @escaping (RepositoryResponse<Bool>) -> Void)
}
