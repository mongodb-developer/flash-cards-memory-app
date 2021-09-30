//
//  File.swift
//  
//
//  Created by Diego Freniche Brito on 30/9/21.
//

import Foundation
import Realm
import FlashCardsDataEntities
import RealmSwift

/// DeckEntity implemented using Realm
public class UserCredentialsEntityRealmImpl: Object, UserCredentialsEntity {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var _partition: String = "partitionKey"

    @Persisted
    public var user: String
    
    @Persisted
    public var password: String
}
