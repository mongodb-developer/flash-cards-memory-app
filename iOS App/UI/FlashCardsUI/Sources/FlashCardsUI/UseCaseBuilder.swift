//
//  Builder.swift
//  FlashCards
//
//  Created by Diego Freniche Brito on 30/9/21.
//

import Foundation
import FlashCardsRepositoriesRealmImpl
import FlashCardsUseCases
import FlashCardsModels
import FlashCardsUseCasesImpl
import FlashCardsRepositoriesImpl
import FlashCardsMappersImpl
import FlashCardsRepositoriesRealmImpl
import FlashCardsRealmMappersImpl

public enum BuildModes {
    case HandMade
    case Realm
    case MongoDBRealm
}

public class UseCaseProvider {
    public static var shared = UseCaseProvider(buildMode: .HandMade)
    
    var useCaseBuilderHandMade: UseCaseBuilder<GetAllDecksUseCaseImpl<DeckRepositoryImpl, DeckEntityToDeckMapperImpl>,
                                                   AddDeckUseCaseImpl<DeckRepositoryImpl, DeckToDeckEntityMapperImpl>,
                                                   DeleteDeckUseCaseImpl<DeckRepositoryImpl, DeckToDeckEntityMapperImpl>,
                                                   AddCardUseCaseImpl<DeckRepositoryImpl, DeckToDeckEntityMapperImpl, FlashCardToCardEntityMapperImpl>>?
    
    var useCaseBuilderRealm   : UseCaseBuilder<GetAllDecksUseCaseImpl<DeckRepositoryRealmImpl, DeckRealmEntityToDeckMapper>,
                                                   AddDeckUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper>,
                                                   DeleteDeckUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper>,
                                                   AddCardUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper, CardToCardRealmEntityMapper>>?
    
    public init(buildMode: BuildModes) {
        switch buildMode {
        case .HandMade:
            
            useCaseBuilderHandMade = UseCaseBuilder<GetAllDecksUseCaseImpl<DeckRepositoryImpl, DeckEntityToDeckMapperImpl>,
                            AddDeckUseCaseImpl<DeckRepositoryImpl, DeckToDeckEntityMapperImpl>,
                            DeleteDeckUseCaseImpl<DeckRepositoryImpl, DeckToDeckEntityMapperImpl>,
                            AddCardUseCaseImpl<DeckRepositoryImpl, DeckToDeckEntityMapperImpl, FlashCardToCardEntityMapperImpl>>(buildMode: .HandMade)
            break
        case .Realm:
            // Using a Local Realm (a file)
            FlashCardsRealm.realm = FlashCardsRealm.initLocalRealm()
            useCaseBuilderRealm = UseCaseBuilder<GetAllDecksUseCaseImpl<DeckRepositoryRealmImpl, DeckRealmEntityToDeckMapper>,
                                                           AddDeckUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper>,
                                                           DeleteDeckUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper>,
                                                 AddCardUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper, CardToCardRealmEntityMapper>>(buildMode: .Realm)
        case .MongoDBRealm:
            // Using Realm Sync (use this OR local Realm, not both)
            FlashCardsRealm.initMongoDBRealm {
                print("Init MongoDB Realm")
                
                self.useCaseBuilderRealm = UseCaseBuilder<GetAllDecksUseCaseImpl<DeckRepositoryRealmImpl, DeckRealmEntityToDeckMapper>,
                                                               AddDeckUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper>,
                                                               DeleteDeckUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper>,
                                                     AddCardUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper, CardToCardRealmEntityMapper>>(buildMode: .MongoDBRealm)
            }
        }
    }
}

public struct UseCaseBuilder<GetAllDecksUseCaseType: GetAllDecksUseCase,
                      AddDeckUseCaseType: AddDeckUseCase,
                      DeleteDeckUseCaseType: DeleteDeckUseCase,
                      AddCardUseCaseType: AddCardUseCase
> {
        
    let buildMode: BuildModes
   
    public func buildGetAllDecksUseCase(completion: (GetAllDecksUseCaseType) -> Void) {
        switch buildMode {
        case .HandMade:
            let useCase = GetAllDecksUseCaseImpl(decksRepository: DeckRepositoryImpl(),
                                                 deckEntityToDeckMapper: DeckEntityToDeckMapperImpl())
            completion(useCase as! GetAllDecksUseCaseType)
        case .Realm, .MongoDBRealm:
            
            let useCase = GetAllDecksUseCaseImpl(decksRepository: DeckRepositoryRealmImpl(),
                                                 deckEntityToDeckMapper: DeckRealmEntityToDeckMapper())
            completion(useCase as! GetAllDecksUseCaseType)
        }
    }
    
    public func buildAddDeckUseCase(completion: (AddDeckUseCaseType) -> Void) {
        switch buildMode {
        case .HandMade:
            let useCase = AddDeckUseCaseImpl(decksRepository: DeckRepositoryImpl(),
                                             deckToDeckEntityMapper: DeckToDeckEntityMapperImpl())
            completion(useCase as! AddDeckUseCaseType)
        case .Realm, .MongoDBRealm:
            
            let useCase = AddDeckUseCaseImpl(decksRepository: DeckRepositoryRealmImpl(),
                                             deckToDeckEntityMapper: DeckToDeckRealmEntityMapper())
            completion(useCase as! AddDeckUseCaseType)
        }
    }
    
    public func buildDeleteDeckUseCase(completion: (DeleteDeckUseCaseType) -> Void) {
        switch buildMode {
        case .HandMade:
            let useCase = DeleteDeckUseCaseImpl(decksRepository: DeckRepositoryImpl(),
                                             deckToDeckEntityMapper: DeckToDeckEntityMapperImpl())
            completion(useCase as! DeleteDeckUseCaseType)
        case .Realm, .MongoDBRealm:
            
            let useCase = DeleteDeckUseCaseImpl(decksRepository: DeckRepositoryRealmImpl(),
                                             deckToDeckEntityMapper: DeckToDeckRealmEntityMapper())
            completion(useCase as! DeleteDeckUseCaseType)
        }
    }
    
    public func buildAddCardUseCase(deck: Deck, completion: (AddCardUseCaseType) -> Void) {
        switch buildMode {
        case .HandMade:
            let useCase = AddCardUseCaseImpl(deck: deck, decksRepository: DeckRepositoryImpl(), deckToDeckEntityMapper: DeckToDeckEntityMapperImpl(), cardToCardEntityMapper: FlashCardToCardEntityMapperImpl())
            completion(useCase as! AddCardUseCaseType)
        case .Realm, .MongoDBRealm:
            
            let useCase = AddCardUseCaseImpl(deck: deck, decksRepository: DeckRepositoryRealmImpl(), deckToDeckEntityMapper: DeckToDeckRealmEntityMapper(), cardToCardEntityMapper: CardToCardRealmEntityMapper())
            completion(useCase as! AddCardUseCaseType)
        }
    }
}
