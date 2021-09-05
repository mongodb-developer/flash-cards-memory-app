//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 4/9/21.
//

import Foundation

public struct DeckNetworkEntity: Decodable {
    public let id: Int
    public let title: String
    public let description: String
    public let icon: String
    public let created: String
    public let updated: String
    public let cards: [CardNetworkEntity]
}
