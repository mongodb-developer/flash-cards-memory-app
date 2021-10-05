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
import FlashCardsUseCasesImpl

public struct ContentView: View {
    
    @State var useCaseFactory: UseCaseFactoryProvider = UseCaseFactoryProvider(buildMode: .HandMade)
    @State var loggedIn: Bool = false
    @State var dataSourceType: DataStorageMode = .HandMade
    
    public init() {
    }
    
    public var body: some View {
        NavigationView {
            if loggedIn {
                DecksView(loggedIn: $loggedIn)
            } else {
                VStack {
                    SelectDataSourceView(dataSourceType: $dataSourceType)
                        .onChange(of: dataSourceType) { newValue in
                            useCaseFactory = UseCaseFactoryProvider(buildMode: dataSourceType)
                            let _ = self.environment(\.useCaseFactory, useCaseFactory)
                        }
                    
                    Spacer()
                        .fixedSize()
                        .padding(.bottom, 30.0)
                    
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
            
        }.environment(\.useCaseFactory, useCaseFactory)
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

// We define a new Environent key here
private struct UseCaseProviderKey: EnvironmentKey {
    static let defaultValue: UseCaseFactoryProvider = UseCaseFactoryProvider(buildMode: .HandMade)
}

extension EnvironmentValues {
    public var useCaseFactory: UseCaseFactoryProvider {
        get { self[UseCaseProviderKey.self] }
        set { self[UseCaseProviderKey.self] = newValue }
    }
}

// Radio Button menu to select Data Source
struct SelectDataSourceView: View {
    @Binding var dataSourceType: DataStorageMode
    
    var body: some View {
        Picker(selection: $dataSourceType, label: Text("Data Source:")) {
            Text("Hand Made").tag(DataStorageMode.HandMade)
            Text("Local Realm DB").tag(DataStorageMode.Realm)
            Text("Cloud MongoDB Realm").tag(DataStorageMode.MongoDBRealm)
        }
        .pickerStyle(.segmented)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
