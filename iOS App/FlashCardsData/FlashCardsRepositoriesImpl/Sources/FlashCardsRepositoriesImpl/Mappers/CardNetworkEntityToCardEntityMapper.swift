//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 5/9/21.
//

import Foundation
import FlashCardsNetwork
import FlashCardsDataEntities
import FlashCardsDataEntitiesImpl


struct CardNetworkEntityToCardEntityMapper {
    static func map(networkEntities: [CardNetworkEntity]) -> [CardEntityImpl] {
        var returnEntities: [CardEntityImpl] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"

        for networkEntity in networkEntities {
            let creationDate = dateFormatter.date(from: networkEntity.created) ?? Date()
            let lastUpdateDate = dateFormatter.date(from: networkEntity.updated) ?? Date()

            let entity = CardEntityImpl(title: networkEntity.title,
                                        description: networkEntity.description,
                                        icon: networkEntity.icon,
                                        creationDate: creationDate,
                                        lastUpdateDate: lastUpdateDate)
            returnEntities.append(entity)
        }
        
        return returnEntities
    }
}
