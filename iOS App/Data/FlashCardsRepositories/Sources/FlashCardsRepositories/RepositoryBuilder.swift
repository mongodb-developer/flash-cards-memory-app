//
//  File.swift
//  
//
//  Created by Diego Freniche Brito on 30/9/21.
//

import Foundation
import FlashCardsDataEntities

public protocol RepositoryBuilder {
    associatedtype BuilderCardRepository
    associatedtype BuilderDeckRepository
    associatedtype BuilderLoginRepository
    associatedtype BuilderDeckEntity

    func getLoginRepository(completion: (BuilderLoginRepository) -> Void)
    func getDeckRepository(completion: (BuilderDeckRepository) -> Void)
    func getCardRepository(deck: BuilderDeckEntity, completion: (BuilderCardRepository) -> Void)
}
