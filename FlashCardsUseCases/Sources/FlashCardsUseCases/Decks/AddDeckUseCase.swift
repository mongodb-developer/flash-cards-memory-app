//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 24/8/21.
//

import Foundation
import FlashCardsModels

public protocol AddDeckUseCase: UseCase where
                                        inParameterDataType == Deck,
                                        resultDataType == Bool {
    
}
