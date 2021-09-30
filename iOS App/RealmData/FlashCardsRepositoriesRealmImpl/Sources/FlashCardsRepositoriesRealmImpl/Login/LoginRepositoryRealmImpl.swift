//
//  File.swift
//  
//
//  Created by Diego Freniche Brito on 30/9/21.
//

import Foundation
import FlashCardsRepositories
import FlashCardsDataEntities
import FlashCardsDataEntitiesRealmImpl

import RealmSwift

public struct LoginRepositoryRealmImpl: LoginRepository {    
    public typealias EntityType = DeckEntityRealmImpl

    public func login(completion: (EntityType) -> Void) {

    }

    public func logout() {

    }

    public func register(user: EntityType) {

    }

}
