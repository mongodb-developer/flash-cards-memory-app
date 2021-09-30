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
public protocol DeckEntityToDeckMapper: Mapper where
                                        InType == DeckEntity,
                                        OutType == Deck
{
    
}
