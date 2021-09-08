//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 4/9/21.
//

import Foundation

/// Cards as downloaded from the network
/// Will be mapped into DataEntities
public struct CardNetworkEntity: Decodable {
    public let id: Int
    public let title: String
    public let description: String
    public let icon: String
    public let created: String
    public let updated: String
}
