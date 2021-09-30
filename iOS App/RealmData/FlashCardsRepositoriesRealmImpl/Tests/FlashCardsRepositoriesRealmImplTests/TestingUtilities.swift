//
//  File.swift
//  
//
//  Created by Diego Freniche Brito on 29/9/21.
//

@testable import FlashCardsRepositoriesRealmImpl
import Foundation
import RealmSwift
import FlashCardsRepositories
import FlashCardsDataEntities
import FlashCardsDataEntitiesRealmImpl

// MARK: - Testing Utilities
    
// clears the Realm
func clearRealm() {
    let realm = initTestRealm()

    do {
        realm?.beginWrite()
        realm?.deleteAll()
        try realm?.commitWrite()
    } catch {
       fatalError("Error writing: \(error)")
    }
}

// creates an in memory Realm, perfect for testing!
func initTestRealm() -> Realm? {
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
        fatalError("Something bad happened: \(error)")
    }
}

func insertDeck(title: String, description: String, icon: String) {
    let repository = DeckRepositoryRealmImpl(realm: initTestRealm()!)

    let deck = DeckEntityRealmImpl(title: title, description: description, icon: icon, creationDate: Date(), lastUpdateDate: Date(), cards: [])
    
    repository.add(deck) { (response: RepositoryResponse<Bool>) in
        // ignored, hope insert is OK, otherwise there are tests to catch it
    }
}

func insertDecks(numOfDecks: Int) {
    for i in 0 ..< numOfDecks {
        insertDeck(title: "Deck Title \(i)", description: "Deck Description \(i)", icon: "Icon \(i)")
    }
}

//    private func insertCardInDeck(deck: DeckRepositoryRealmImpl, title: String, description: String, icon: String) {
//        let repository = DeckRepositoryRealmImpl(realm: initTestRealm()!)
//
//        let card = CardEntityRealmImpl(title: "Card 1", description: "Desc Card 1", icon: "Icon 1", creationDate: Date(), lastUpdateDate: Date())
//        repository.addCard(card, deck: deck as! DeckEntity) { (response: RepositoryResponse<Bool>) in
//            // ignored, hope insert is OK, otherwise there are tests to catch it
//
//        }
//    }
