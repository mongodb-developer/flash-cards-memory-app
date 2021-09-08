//
//  FlashCardsApp.swift
//  FlashCards
//
//  Created by Diego Freniche Brito on 24/8/21.
//

import SwiftUI
import FlashCardsUI
import FlashCardsRepositoriesRealmImpl

@main
struct FlashCardsApp: App {
    @State var realmInit = false
    
    public init() {
        // Using Realm Sync (use this OR local Realm, not both)
//        CardsRealm.initMongoDBRealm {  [self] in
//            print("Init")
//            realmInit = true
//        }
        
        // Using a Local Realm (a file)
        CardsRealm.realm = CardsRealm.initLocalRealm()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
