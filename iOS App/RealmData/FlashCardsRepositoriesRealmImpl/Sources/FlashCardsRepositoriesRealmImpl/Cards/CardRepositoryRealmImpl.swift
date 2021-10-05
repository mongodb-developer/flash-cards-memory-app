//
//  File.swift
//  
//
//  Created by Diego Freniche Brito on 29/9/21.
//

import Foundation

import FlashCardsRepositories
import FlashCardsDataEntities
import FlashCardsDataEntitiesRealmImpl
import FlashCardsRealmInit

import RealmSwift

public struct CardRepositoryRealmImpl: CardRepository {

    public typealias EntityType = CardEntityRealmImpl

    public let deck: DeckEntity

    static var realm: Realm?
    
    public init(deck: DeckEntityRealmImpl) {
        self.deck = deck
        DeckRepositoryRealmImpl.realm = FlashCardsRealm.realm
    }
    
    public init(deck: DeckEntityRealmImpl, realm: Realm?) {
        self.deck = deck
        DeckRepositoryRealmImpl.realm = realm
    }
    
    
    public func add(_ entity: CardEntityRealmImpl, completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        guard let deck = self.deck as? DeckEntityRealmImpl else {
            completion(RepositoryResponse<Bool>(code: 0, message: "Error", data: false))
            return
        }
        
        deck.addCard(entity)
        completion(RepositoryResponse<Bool>(code: 0, message: "Success", data: true))
    }
    
    public func getAll(completion: @escaping (RepositoryResponse<[CardEntityRealmImpl]>) -> Void) {
        
    }
    
    public func delete(_ entity: CardEntityRealmImpl, completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        
    }
    
    public func update(_ entity: CardEntityRealmImpl, completion: @escaping (RepositoryResponse<CardEntityRealmImpl>) -> Void) {
        
    }
    
    public func deleteAll(completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        
    }
}
