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
import FlashCardsPersistence
import FlashCardsNetwork

public struct LoginRepositoryImpl: LoginRepository {
    public typealias UserCredentialsEntity = UserCredentialsEntityImpl

    public func login(completion: (UserCredentialsEntityImpl) -> Void) {
        // I leave this as an exercise to the reader
    }
    
    public func logout() {
        // I leave this as an exercise to the reader
    }
    
    public func register(user: UserCredentialsEntityImpl) {
        // I leave this as an exercise to the reader
    }
}
