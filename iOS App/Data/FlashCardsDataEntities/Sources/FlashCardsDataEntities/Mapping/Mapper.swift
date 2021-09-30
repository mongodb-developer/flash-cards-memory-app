//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 7/9/21.
//

import Foundation

public protocol Mapper {
    associatedtype InType
    associatedtype OutType
    
    func map(_ inData: InType) -> OutType
}
