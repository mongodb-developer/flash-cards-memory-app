//
//  File.swift
//  
//
//  Created by Diego Freniche Brito on 28/9/21.
//

import Foundation
import FlashCardsDataEntities

/// A Repository to abstract CRUD operations for Cards
public protocol CardRepository: Repository {
    
    // deck all these cards belong
    var deck: DeckEntity { get }
}

