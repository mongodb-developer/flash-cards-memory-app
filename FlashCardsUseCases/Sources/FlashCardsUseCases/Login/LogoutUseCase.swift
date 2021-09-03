//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 25/8/21.
//

import Foundation

public protocol LogoutUseCase: UseCase where
                                       inParameterDataType == Void,
                                       resultDataType == Bool {
    
}
