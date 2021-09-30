//
//  File.swift
//  
//
//  Created by Diego Freniche Brito on 28/9/21.
//

import Foundation
import FlashCardsRepositories
import FlashCardsDataEntities

public struct CardRepositoryImpl: CardRepository {
    public typealias EntityType = CardEntity

    public let deck: DeckEntity

    public init(deck: DeckEntity) {
        self.deck = deck
    }
    
    public func add(_ entity: CardEntity, completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        
    }
    
    public func getAll(completion: @escaping (RepositoryResponse<[CardEntity]>) -> Void) {
        
    }
    
    public func delete(_ entity: CardEntity, completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        
    }
    
    public func deleteAll(completion: @escaping (RepositoryResponse<Bool>) -> Void) {
        
    }
    
    public func update(_ entity: CardEntity, completion: @escaping (RepositoryResponse<CardEntity>) -> Void) {
        
    }
}
