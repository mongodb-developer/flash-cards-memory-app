//
//  ContentView.swift
//  FlashCards
//
//  Created by Diego Freniche Brito on 24/8/21.
//

import SwiftUI
import FlashCardsModels
import FlashCardsUseCases
import FlashCardsUseCasesImpl
import FlashCardsRepositoriesRealmImpl

public struct ContentView: View {
    
    @State var loggedIn: Bool = false
    
    public init() {
    }
    
    public var body: some View {
        NavigationView {
            if loggedIn {
                DecksView(loggedIn: $loggedIn)
            } else {
                VStack {
                    // Link to Register
                    RegisterLinkView()
                    
                    Spacer()
                        .fixedSize()
                        .padding(.bottom, 30.0)
                    
                    // Login
                    LoginView(user: "", password: "") { (user, password) in
                        loggedIn = true
                        
                        // TODO: Call loging use case
                    }
                    
                    Spacer()
                }
            }
            
        }
    }    
}

struct RegisterLinkView: View {
    var body: some View {
        HStack {
            Spacer()
            NavigationLink {
                RegisterView { (uc: UserCredentials) in
                    
                }
            } label: {
                Text("Register")
            }.padding(.trailing, 30.0)
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}