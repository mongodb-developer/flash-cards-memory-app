//
//  File.swift
//  
//
//  Created by Diego Freniche Brito on 29/9/21.
//

import Foundation
import FlashCardsDataEntities
import FlashCardsModels

public protocol FlashCardToCardEntityMapper: Mapper {
    
    typealias InType = Card
    typealias OutType = CardEntity
}
