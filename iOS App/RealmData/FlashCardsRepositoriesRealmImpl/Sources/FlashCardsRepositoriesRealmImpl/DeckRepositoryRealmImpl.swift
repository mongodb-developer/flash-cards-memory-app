import Foundation
import FlashCardsRepositories
import FlashCardsDataEntities

import RealmSwift

public struct CardsRealm {
    public static var realm: Realm?

    public static func initLocalRealm() -> Realm? {
        do {
            let fileUrl = Realm.Configuration().fileURL!.deletingLastPathComponent()
                    .appendingPathComponent("FlashCards.realm")
            
            let configuration = Realm.Configuration(fileURL: fileUrl,
                                                    syncConfiguration: nil, encryptionKey: nil,
                                                    readOnly: false, schemaVersion: 1,
                                                    migrationBlock: nil,
                                                    deleteRealmIfMigrationNeeded: true,
                                                    shouldCompactOnLaunch: nil, objectTypes: nil)
            let realm = try Realm(configuration: configuration, queue: .main)
            return realm
        } catch {
            print("Something bad happened: \(error)")
            return nil
        }
    }
    
    public static func initMongoDBRealm(completion: @escaping () -> Void) -> Void {
       
        let app = App(id: "flashcards-spblk")
        
        // Log in anonymously.
        app.login(credentials: Credentials.anonymous) { (result) in
            // Remember to dispatch back to the main thread in completion handlers
            // if you want to do anything on the UI.
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print("Login failed: \(error)")
                    completion()

                case .success(let user):
                    print("Login as \(user) succeeded!")
                    // The partition determines which subset of data to access.
                    let partitionValue = "partitionKey"
                    // Get a sync configuration from the user object.
                    let configuration = user.configuration(partitionValue: partitionValue)
                    // Open the realm asynchronously to ensure backend data is downloaded first.
                    Realm.asyncOpen(configuration: configuration) { (result) in
                        switch result {
                        case .failure(let error):
                            print("Failed to open realm: \(error.localizedDescription)")
                            // Handle error...
                            completion()
                        case .success(let mongoDBRealm):
                            // Realm opened
                            realm = mongoDBRealm
                            completion()
                        }
                    }
                }
            }
        }
    }
}

public struct DeckRepositoryRealmImpl: DeckRepository {
    
    static var realm: Realm?

    public typealias DeckEntityType = DeckEntityRealmImpl
    public typealias CardEntityType = CardEntityRealmImpl
    
    public init() {
        DeckRepositoryRealmImpl.realm = CardsRealm.realm
    }
    
    public init(realm: Realm?) {
        DeckRepositoryRealmImpl.realm = realm
    }

    
    public func getAllDecks(completion: @escaping (RepositoryResponse<[DeckEntityType]>) -> Void) {
        guard let realm = DeckRepositoryRealmImpl.realm
        else {
            completion(RepositoryResponse<[DeckEntityType]>(code: 0, message: "Error in preconditions", data: []))
            return
        }
        
        let decks = realm.objects(DeckEntityRealmImpl.self)
        var returnArray: [DeckEntityRealmImpl] = []
        decks.enumerated().forEach { (index, entry) in
            print("[ \(entry.title) ] \(entry.description)")
            returnArray.append(entry)
        }
        
        let response = RepositoryResponse<[DeckEntityType]>(code: 200, message: "All OK", data: returnArray)
        
        completion(response)
    }
    
    
    /// Finds a Realm Deck using title and description from the passed Deck
    /// - Parameters:
    ///   - deck: a Deck coming from the Model
    ///   - completion: we return the found Realm Deck if any
    public func findDeck(_ deck: DeckEntityType, completion: @escaping (RepositoryResponse<DeckEntityRealmImpl?>) -> Void) {
        guard let realm = DeckRepositoryRealmImpl.realm
        else {
            completion(RepositoryResponse<DeckEntityRealmImpl?>(code: 0, message: "Error in preconditions", data: nil))
            return
        }
        
        let foundDeck = realm.objects(DeckEntityType.self).filter("title == %@ AND deckDescription == %@", deck.title, deck.deckDescription).first
        
        let response = RepositoryResponse<DeckEntityRealmImpl?>(code: 200, message: "All OK", data: foundDeck)
        
        completion(response)
    }
    
    
    public func deleteDeck(_ deck: DeckEntityType, completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        guard let realm = DeckRepositoryRealmImpl.realm
        else {
            completion(RepositoryResponse<Bool>(code: 0, message: "Error in preconditions", data: false))
            return
        }

        do {
           try realm.write {
               realm.delete(deck)
               completion(RepositoryResponse<Bool>(code: 200, message: "Delete OK", data: true))
           }
        } catch {
            completion(RepositoryResponse<Bool>(code: 0, message: "Error deleting: \(error)", data: false))
        }
    }
    
    public func deleteAllDecks(completion: @escaping (RepositoryResponse<Bool>) -> Void) {
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
    
   
    public func updateDeck(_ deck: DeckEntityType, completion: @escaping (RepositoryResponse<DeckEntityType>) -> Void) {
        guard let realm = DeckRepositoryRealmImpl.realm
        else {
            completion(RepositoryResponse<DeckEntityType>(code: 0, message: "Error in preconditions", data: deck))
            return
        }

        do {
           try realm.write {
               try realm.commitWrite()
               completion(RepositoryResponse<DeckEntityType>(code: 200, message: "Delete All OK", data: deck))
           }
        } catch {
            completion(RepositoryResponse<DeckEntityType>(code: 0, message: "Error deleting: \(error)", data: deck))
        }
    }
    
    public func addDeck(_ deck: DeckEntityType, completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        guard let realm = DeckRepositoryRealmImpl.realm else {
            completion(RepositoryResponse<Bool>(code: 0, message: "Error in preconditions", data: false))
            return
        }
        
        findDeck(deck) { (response: RepositoryResponse<DeckEntityRealmImpl?>) in
            let deckToSave: DeckEntityRealmImpl
            if response.data != nil {
                deckToSave = response.data!
            } else {
                deckToSave = DeckEntityRealmImpl(title: deck.title,
                                                  description: deck.deckDescription,
                                                  icon: deck.icon,
                                                  creationDate: deck.creationDate,
                                                  lastUpdateDate: deck.lastUpdateDate,
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
    
    public func addCard(_ card: CardEntityType, deck: DeckEntityType, completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        guard let realm = DeckRepositoryRealmImpl.realm else {
            completion(RepositoryResponse<Bool>(code: 0, message: "Error in preconditions", data: false))
            return
        }
        
        findDeck(deck) { (response: RepositoryResponse<DeckEntityRealmImpl?>) in
            if let foundDeck = response.data {
                
                do {
                    try realm.write {
                        foundDeck.addCard(CardEntityRealmImpl(cardEntity: card))

                        completion(RepositoryResponse<Bool>(code: 200, message: "Add Card OK", data: true))
                    }
                } catch {
                    completion(RepositoryResponse<Bool>(code: 0, message: "Error adding: \(error)", data: false))
                }
                
            } else {
                completion(RepositoryResponse<Bool>(code: 0, message: "Error adding: not found", data: false))
            }
        }
        
        
    }
}
