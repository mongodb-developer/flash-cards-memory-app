//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 1/9/21.
//

import Foundation
import FlashCardsModels

public struct FlashCardsUserCredentials: UserCredentials {
    public let user: String    
    public let password: String
    
    public init(user: String, password: String) {
        self.user = user
        self.password = password
    }
}
