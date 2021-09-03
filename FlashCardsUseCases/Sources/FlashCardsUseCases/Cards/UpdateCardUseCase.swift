//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 3/9/21.
//

import Foundation
import FlashCardsModels

public protocol UpdateCardUseCase: UseCase where
                                        inParameterDataType == Card,
                                        resultDataType == Bool {
    
}
