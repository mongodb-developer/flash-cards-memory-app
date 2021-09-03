//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 24/8/21.
//

import Foundation
public protocol CardEntity {
    var title: String { get }
    var description: String { get }
    var icon: String { get }
    var creationDate: Date { get }
    var lastUpdateDate: Date { get }
}
