//
//  File.swift
//  
//
//  Created by Diego Freniche Brito on 29/9/21.
//

import Foundation
import FlashCardsDataEntities
import FlashCardsModels

// DeckEntity --> Deck
public protocol DeckToDeckEntityMapper: Mapper where
                                                InType == Deck,
                                                OutType == DeckEntity {
        
}
