//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 24/8/21.
//

import Foundation
import FlashCardsModels

public protocol GetAllDecksUseCase: UseCase where
                                    inParameterDataType == Void,
                                    resultDataType == [Deck] {
    
}
