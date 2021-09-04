import FlashCardsDataEntities

public protocol DeckRepository {
    func getAllDecks(completion: ([DeckEntity]) -> Void)
    func deleteDeck(_ deck: DeckEntity)
    func updateDeck(_ deck: DeckEntity)
    func addDeck(_ deck: DeckEntity)
}
