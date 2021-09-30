//
//  File.swift
//  
//
//  Created by Diego Freniche Brito on 30/9/21.
//

import Foundation
import FlashCardsRepositories
import FlashCardsDataEntities
import FlashCardsDataEntitiesImpl

public struct FlashCardRepositoryBuilderImpl: RepositoryBuilder {

    public typealias BuilderCardRepository = CardRepositoryImpl
    
    public typealias BuilderDeckRepository = DeckRepositoryImpl
    
    public typealias BuilderLoginRepository = LoginRepositoryImpl
    
   
    public func getCardRepository(deck: DeckEntity, completion: (CardRepositoryImpl) -> Void) {
        let cardRepository = CardRepositoryImpl(deck: deck)
        completion(cardRepository)
    }
    
    public func getDeckRepository(completion: (DeckRepositoryImpl) -> Void) {
        let deckRepository = DeckRepositoryImpl()
        completion(deckRepository)
    }
    
    public func getLoginRepository(completion: (LoginRepositoryImpl) -> Void) {
        let loginRepository = LoginRepositoryImpl()
        completion(loginRepository)
    }
}
