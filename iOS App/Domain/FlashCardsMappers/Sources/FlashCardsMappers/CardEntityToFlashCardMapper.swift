//
//  File.swift
//  
//
//  Created by Diego Freniche Brito on 29/9/21.
//

import Foundation
import FlashCardsDataEntities
import FlashCardsModels

// CardEntity --> Card
public protocol CardEntityToFlashCardMapper: Mapper {
    
    typealias InType = CardEntity
    typealias OutType = Card
}
