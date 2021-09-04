//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 25/8/21.
//

import Foundation
import FlashCardsDataEntities

public struct UserCredentialsEntityImpl: UserCredentialsEntity {
    public let user: String
    public let password: String
    
    public init(user: String, password: String) {
        self.user = user
        self.password = password
    }
}

