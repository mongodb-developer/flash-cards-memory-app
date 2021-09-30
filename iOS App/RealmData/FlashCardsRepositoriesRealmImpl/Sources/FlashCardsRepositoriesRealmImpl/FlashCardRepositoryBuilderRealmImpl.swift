//
//  File.swift
//  
//
//  Created by Diego Freniche Brito on 30/9/21.
//

import Foundation
import FlashCardsRepositories
import FlashCardsDataEntitiesRealmImpl

public struct FlashCardRepositoryBuilderRealmImpl: RepositoryBuilder {

    public typealias BuilderCardRepository = CardRepositoryRealmImpl
    
    public typealias BuilderDeckRepository = DeckRepositoryRealmImpl
    
    public typealias BuilderLoginRepository = LoginRepositoryRealmImpl
    
   
    public func getCardRepository(deck: DeckEntityRealmImpl, completion: (CardRepositoryRealmImpl) -> Void) {
        let cardRepository = CardRepositoryRealmImpl(deck: deck)
        completion(cardRepository)
    }
    
    public func getDeckRepository(completion: (DeckRepositoryRealmImpl) -> Void) {
        let deckRepository = DeckRepositoryRealmImpl()
        completion(deckRepository)
    }
    
    public func getLoginRepository(completion: (LoginRepositoryRealmImpl) -> Void) {
        let loginRepository = LoginRepositoryRealmImpl()
        completion(loginRepository)
    }
}
