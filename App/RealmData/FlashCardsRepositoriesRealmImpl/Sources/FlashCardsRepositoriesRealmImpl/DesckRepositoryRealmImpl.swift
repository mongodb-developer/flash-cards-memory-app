import Foundation
import FlashCardsRepositories
import FlashCardsDataEntities

import RealmSwift

public struct DeckRepositoryRealmImpl: DeckRepository {
    
    static var realm: Realm? = initRealm()
    
    static func initRealm() -> Realm? {
        do {
            let configuration = Realm.Configuration(fileURL: nil,
                                                    inMemoryIdentifier: "inMemory",
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
    
    public init() {
        
    }
    
    public init(realm: Realm?) {
        DeckRepositoryRealmImpl.realm = realm
    }

    
    public func getAllDecks(completion: @escaping (RepositoryResponse<[DeckEntity]>) -> Void) {
        guard let realm = DeckRepositoryRealmImpl.realm
        else {
            completion(RepositoryResponse<[DeckEntity]>(code: 0, message: "Error in preconditions", data: []))
            return
        }
        
        let decks = realm.objects(DeckEntityRealmImpl.self)
        var returnArray: [DeckEntity] = []
        decks.enumerated().forEach { (index, entry) in
            print("[ \(entry.title) ] \(entry.description)")
            returnArray.append(entry)
        }
        
        let response = RepositoryResponse<[DeckEntity]>(code: 200, message: "All OK", data: returnArray)
        
        completion(response)
    }
    
    public func deleteDeck(_ deck: DeckEntity, completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        guard let realm = DeckRepositoryRealmImpl.realm,
              let realmDeck = deck as? DeckEntityRealmImpl
        else {
            completion(RepositoryResponse<Bool>(code: 0, message: "Error in preconditions", data: false))
            return
        }

        do {
           try realm.write {
               realm.delete(realmDeck)
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
    
    public func updateDeck(_ deck: DeckEntity, completion: @escaping (RepositoryResponse<DeckEntity>) -> Void) {
        guard let realm = DeckRepositoryRealmImpl.realm
        else {
            completion(RepositoryResponse<DeckEntity>(code: 0, message: "Error in preconditions", data: deck))
            return
        }

        do {
           try realm.write {
               try realm.commitWrite()
               completion(RepositoryResponse<DeckEntity>(code: 200, message: "Delete All OK", data: deck))
           }
        } catch {
            completion(RepositoryResponse<DeckEntity>(code: 0, message: "Error deleting: \(error)", data: deck))
        }
    }
    
    public func addDeck(_ deck: DeckEntity, completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        guard let realm = DeckRepositoryRealmImpl.realm,
              let realmDeck = deck as? DeckEntityRealmImpl else {
            completion(RepositoryResponse<Bool>(code: 0, message: "Error in preconditions", data: false))
            return
        }
        
        do {
            try realm.write {
               realm.add(realmDeck)
               completion(RepositoryResponse<Bool>(code: 200, message: "Insert OK", data: true))
            }
        } catch {
            completion(RepositoryResponse<Bool>(code: 0, message: "Error writing: \(error)", data: false))

        }
    }
}
