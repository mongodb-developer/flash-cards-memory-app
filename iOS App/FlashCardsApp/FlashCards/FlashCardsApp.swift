//
//  FlashCardsApp.swift
//  FlashCards
//
//  Created by Diego Freniche Brito on 24/8/21.
//

import SwiftUI
import FlashCardsUI
import FlashCardsRepositoriesRealmImpl
import FlashCardsUseCasesImpl
import FlashCardsRepositoriesImpl
import FlashCardsMappersImpl
import FlashCardsRealmMappersImpl

@main
struct FlashCardsApp: App {
    @State var realmInit = false
    
    
    public init() {
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


