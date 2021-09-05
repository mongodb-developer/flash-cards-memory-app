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

struct DeckNetworkEntityToDeckEntityMapper {
    static func map(networkEntities: [DeckNetworkEntity]) -> [DeckEntityImpl] {
        var returnEntities: [DeckEntityImpl] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"

         // nil
        for networkEntity in networkEntities {
            let creationDate = dateFormatter.date(from: networkEntity.created) ?? Date()
            let lastUpdateDate = dateFormatter.date(from: networkEntity.updated) ?? Date()

            let entity = DeckEntityImpl(title: networkEntity.title,
                                        description: networkEntity.description,
                                        icon: networkEntity.icon,
                                        creationDate: creationDate,
                                        lastUpdateDate: lastUpdateDate,
                                        cards: [])
            returnEntities.append(entity)
        }
        
        return returnEntities
    }
}
