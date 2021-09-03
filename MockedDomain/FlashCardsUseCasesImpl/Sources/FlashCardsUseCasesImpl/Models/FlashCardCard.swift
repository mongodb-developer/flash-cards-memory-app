//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 31/8/21.
//

import Foundation
import FlashCardsModels

public struct FlashCard: Card {
    public let title: String
    public let description: String
    public let icon: String
    public let creationDate: Date
    public let lastUpdateDate: Date
    
    public init(title: String,
                description: String,
                icon: String,
                creationDate: Date,
                lastUpdateDate: Date) {
        self.title = title
        self.description = description
        self.icon = icon
        self.creationDate = creationDate
        self.lastUpdateDate = lastUpdateDate
    }
}
