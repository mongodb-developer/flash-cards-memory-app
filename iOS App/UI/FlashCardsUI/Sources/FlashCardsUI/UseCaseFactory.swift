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
import FlashCardsRealmInit

/// Different data storage modes in our app
public enum DataStorageMode {
    case HandMade       // Doing everything manually: threading, caching, networking, JSON mapping, etc.
    case Realm          // Using a local Realm DB
    case MongoDBRealm   // Using a MongoDB Realm synced DB
}

/// Returns a specialized Use Case Factory for each different ``BuildModes``
public class UseCaseFactoryProvider {
    public static var shared = UseCaseFactoryProvider(buildMode: .HandMade)
    
    var useCaseFactoryHandMade: UseCaseFactory<GetAllDecksUseCaseImpl<DeckRepositoryImpl, DeckEntityToDeckMapperImpl>,
                                                   AddDeckUseCaseImpl<DeckRepositoryImpl, DeckToDeckEntityMapperImpl>,
                                                   DeleteDeckUseCaseImpl<DeckRepositoryImpl, DeckToDeckEntityMapperImpl>,
                                                   AddCardUseCaseImpl<DeckRepositoryImpl, DeckToDeckEntityMapperImpl, FlashCardToCardEntityMapperImpl>>?
    
    var useCaseFactoryRealm   : UseCaseFactory<GetAllDecksUseCaseImpl<DeckRepositoryRealmImpl, DeckRealmEntityToDeckMapper>,
                                                   AddDeckUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper>,
                                                   DeleteDeckUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper>,
                                                   AddCardUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper, CardToCardRealmEntityMapper>>?
    
    public init(buildMode: DataStorageMode) {
        switch buildMode {
        case .HandMade:
            useCaseFactoryHandMade = UseCaseFactory<GetAllDecksUseCaseImpl<DeckRepositoryImpl, DeckEntityToDeckMapperImpl>,
                            AddDeckUseCaseImpl<DeckRepositoryImpl, DeckToDeckEntityMapperImpl>,
                            DeleteDeckUseCaseImpl<DeckRepositoryImpl, DeckToDeckEntityMapperImpl>,
                            AddCardUseCaseImpl<DeckRepositoryImpl, DeckToDeckEntityMapperImpl, FlashCardToCardEntityMapperImpl>>(buildMode: .HandMade)
            break
        case .Realm:
            // Using a Local Realm (a file)
            FlashCardsRealm.realm = FlashCardsRealm.initLocalRealm()
            useCaseFactoryRealm = UseCaseFactory<GetAllDecksUseCaseImpl<DeckRepositoryRealmImpl, DeckRealmEntityToDeckMapper>,
                                                           AddDeckUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper>,
                                                           DeleteDeckUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper>,
                                                 AddCardUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper, CardToCardRealmEntityMapper>>(buildMode: .Realm)
        case .MongoDBRealm:
            // Using Realm Sync (use this OR local Realm, not both)
            FlashCardsRealm.initMongoDBRealm {
                print("Init MongoDB Realm")
                
                self.useCaseFactoryRealm = UseCaseFactory<GetAllDecksUseCaseImpl<DeckRepositoryRealmImpl, DeckRealmEntityToDeckMapper>,
                                                               AddDeckUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper>,
                                                               DeleteDeckUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper>,
                                                     AddCardUseCaseImpl<DeckRepositoryRealmImpl, DeckToDeckRealmEntityMapper, CardToCardRealmEntityMapper>>(buildMode: .MongoDBRealm)
            }
        }
    }
}


/// We create new use cases using this Factory
public struct UseCaseFactory<GetAllDecksUseCaseType: GetAllDecksUseCase,
                      AddDeckUseCaseType: AddDeckUseCase,
                      DeleteDeckUseCaseType: DeleteDeckUseCase,
                      AddCardUseCaseType: AddCardUseCase
> {
    let buildMode: DataStorageMode
    
    /// Creates and return a ``GetAllDecksUseCaseType``, to list our Decks
    /// - Parameter completion: closure to return the use case
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
