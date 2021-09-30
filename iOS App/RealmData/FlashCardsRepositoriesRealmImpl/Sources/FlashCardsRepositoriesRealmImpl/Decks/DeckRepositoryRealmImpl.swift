import Foundation
import FlashCardsRepositories
import FlashCardsDataEntities
import FlashCardsDataEntitiesRealmImpl

import RealmSwift

public struct DeckRepositoryRealmImpl: DeckRepository {
    
    public typealias EntityType = DeckEntityRealmImpl
        
    static var realm: Realm?
    
    public init() {
        DeckRepositoryRealmImpl.realm = FlashCardsRealm.realm
    }
    
    public init(realm: Realm?) {
        DeckRepositoryRealmImpl.realm = realm
    }
    public func add(_ entity: DeckEntityRealmImpl, completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        guard let realm = DeckRepositoryRealmImpl.realm else {
            completion(RepositoryResponse<Bool>(code: 0, message: "Error in preconditions", data: false))
            return
        }
        
        findDeck(entity) { (response: RepositoryResponse<DeckEntityRealmImpl?>) in
            let deckToSave: DeckEntityRealmImpl
            if response.data != nil {
                deckToSave = response.data!
            } else {
                deckToSave = DeckEntityRealmImpl(title: entity.title,
                                                  description: entity.deckDescription,
                                                  icon: entity.icon,
                                                  creationDate: entity.creationDate,
                                                  lastUpdateDate: entity.lastUpdateDate,
                                                  cards: [])
            }
            
            do {
                try realm.write {
                   realm.add(deckToSave)
                   completion(RepositoryResponse<Bool>(code: 200, message: "Insert OK", data: true))
                }
            } catch {
                completion(RepositoryResponse<Bool>(code: 0, message: "Error writing: \(error)", data: false))

            }
        }
    }
    
    public func getAll(completion: @escaping (RepositoryResponse<[DeckEntityRealmImpl]>) -> Void) {
        guard let realm = DeckRepositoryRealmImpl.realm
        else {
            completion(RepositoryResponse<[DeckEntityRealmImpl]>(code: 0, message: "Error in preconditions", data: []))
            return
        }
        
        let decks = realm.objects(DeckEntityRealmImpl.self)
        var returnArray: [DeckEntityRealmImpl] = []
        decks.enumerated().forEach { (index, entry) in
            print("[ \(entry.title) ] \(entry.description)")
            returnArray.append(entry)
        }
        
        let response = RepositoryResponse<[DeckEntityRealmImpl]>(code: 200, message: "All OK", data: returnArray)
        
        completion(response)
    }
    
    public func delete(_ entity: DeckEntityRealmImpl, completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        guard let realm = DeckRepositoryRealmImpl.realm
        else {
            completion(RepositoryResponse<Bool>(code: 0, message: "Error in preconditions", data: false))
            return
        }

        do {
           try realm.write {
               realm.delete(entity)
               completion(RepositoryResponse<Bool>(code: 200, message: "Delete OK", data: true))
           }
        } catch {
            completion(RepositoryResponse<Bool>(code: 0, message: "Error deleting: \(error)", data: false))
        }
    }
    
    public func deleteAll(completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        guard let realm = DeckRepositoryRealmImpl.realm
        else {
            completion(RepositoryResponse<Bool>(code: 0, message: "Error in preconditions", data: false))
            return
        }

        let decks = realm.objects(DeckEntityRealmImpl.self)

        do {
           try realm.write {
               realm.delete(decks)
               completion(RepositoryResponse<Bool>(code: 200, message: "Delete All OK", data: true))
           }
        } catch {
            completion(RepositoryResponse<Bool>(code: 0, message: "Error deleting: \(error)", data: false))
        }
    }
    
    public func update(_ entity: DeckEntityRealmImpl, completion: @escaping (RepositoryResponse<DeckEntityRealmImpl>) -> Void) {
        guard let realm = DeckRepositoryRealmImpl.realm
        else {
            completion(RepositoryResponse<DeckEntityRealmImpl>(code: 0, message: "Error in preconditions", data: entity))
            return
        }

        do {
           try realm.write {
               try realm.commitWrite()
               completion(RepositoryResponse<DeckEntityRealmImpl>(code: 200, message: "Delete All OK", data: entity))
           }
        } catch {
            completion(RepositoryResponse<DeckEntityRealmImpl>(code: 0, message: "Error deleting: \(error)", data: entity))
        }
    }
    
    /// Finds a Realm Deck using title and description from the passed Deck
    /// - Parameters:
    ///   - deck: a Deck coming from the Model
    ///   - completion: we return the found Realm Deck if any
    public func findDeck(_ deck: DeckEntityRealmImpl, completion: @escaping (RepositoryResponse<DeckEntityRealmImpl?>) -> Void) {
        guard let realm = DeckRepositoryRealmImpl.realm
        else {
            completion(RepositoryResponse<DeckEntityRealmImpl?>(code: 0, message: "Error in preconditions", data: nil))
            return
        }
        
        let foundDeck = realm.objects(DeckEntityRealmImpl.self).filter("title == %@ AND deckDescription == %@", deck.title, deck.deckDescription).first
        
        let response = RepositoryResponse<DeckEntityRealmImpl?>(code: 200, message: "All OK", data: foundDeck)
        
        completion(response)
    }
    
//    public func addCard(_ card: CardEntityType, deck: DeckEntityRealmImpl, completion: @escaping (RepositoryResponse<Bool>) -> Void) {
//        guard let realm = DeckRepositoryRealmImpl.realm else {
//            completion(RepositoryResponse<Bool>(code: 0, message: "Error in preconditions", data: false))
//            return
//        }
//        
//        findDeck(deck) { (response: RepositoryResponse<DeckEntityRealmImpl?>) in
//            if let foundDeck = response.data {
//                
//                do {
//                    try realm.write {
//                        foundDeck.addCard(CardEntityRealmImpl(cardEntity: card))
//
//                        completion(RepositoryResponse<Bool>(code: 200, message: "Add Card OK", data: true))
//                    }
//                } catch {
//                    completion(RepositoryResponse<Bool>(code: 0, message: "Error adding: \(error)", data: false))
//                }
//                
//            } else {
//                completion(RepositoryResponse<Bool>(code: 0, message: "Error adding: not found", data: false))
//            }
//        }
//    }
}
