//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 1/9/21.
//

import Foundation
import FlashCardsModels

public protocol AddCardUseCase: UseCase where
                                        inParameterDataType == Card,
                                        resultDataType == Bool {
    
}
