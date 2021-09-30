//
//  SwiftUIView.swift
//  SwiftUIView
//
//  Created by Diego Freniche Brito on 25/8/21.
//

import SwiftUI
import FlashCardsUseCases
import FlashCardsModels
import FlashCardsUseCasesImpl
import FlashCardsRepositoriesRealmImpl
import FlashCardsRepositoriesImpl
import FlashCardsModelsImpl

struct DecksView: View {
    
    @Environment(\.useCaseProvider) var useCaseProvider

    @Binding var loggedIn: Bool
    
    let columns = [
        GridItem(.flexible())
    ]
    
    @State var deckViews: [DeckViewModel] = []

    @State var newDeckTitle: String = ""
    @State var newDeckDescription: String = ""
    @State var newDeckIcon: String = ""
    
    @State var shouldSave: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(deckViews) { deck in
                    NavigationLink(destination: DeckDetailView(deck: deck.deck)) {
                        deck
                    }
                }
            }
            .padding(.all, 10)
        }
        // Navigation Bar
        .navigationTitle("\(deckViews.count) Decks")
        .navigationBarItems(trailing:
            NavigationLink("Add") {
            AddDeckView(title: $newDeckTitle, description: $newDeckDescription, icon: $newDeckIcon, shouldSave: $shouldSave)
            }
        )
        .navigationBarItems(leading:
            Button(action: {
                loggedIn = false

                print("Logout button pressed...")
            }) {
                Text("Logout")
            }
        )
        // Loading code
        .onAppear {
            if shouldSave {
                
                let deck = FlashCardDeck(title: newDeckTitle, description: newDeckDescription, icon: newDeckIcon, creationDate: Date(), lastUpdateDate: Date(), cards: [])

                
                useCaseProvider.useCaseBuilderHandMade?.buildAddDeckUseCase(completion: { addDeckUseCase in
                    addDeckUseCase.execute(data: deck) { (result: UseCaseResult<Bool>) in
                        shouldSave = false
                        newDeckTitle = ""
                        newDeckDescription = ""
                        newDeckIcon = ""
                    }
                })
                
                useCaseProvider.useCaseBuilderRealm?.buildAddDeckUseCase(completion: { addDeckUseCase in
                    addDeckUseCase.execute(data: deck) { (result: UseCaseResult<Bool>) in
                        shouldSave = false
                        newDeckTitle = ""
                        newDeckDescription = ""
                        newDeckIcon = ""
                    }
                })
            }
            
            refresh()
        }
    }
}

extension DecksView {
    func refresh() {
        
        useCaseProvider.useCaseBuilderHandMade?.buildGetAllDecksUseCase(completion: { useCase in
            useCase.execute { (result: UseCaseResult<[Deck]>) in
                deckViews = []
                for d in result.value {
                    deckViews.append(DeckViewModel(title: d.title, icon: d.icon, deck: d))
                }
            }
        })
        
        useCaseProvider.useCaseBuilderRealm?.buildGetAllDecksUseCase(completion: { useCase in
            useCase.execute { (result: UseCaseResult<[Deck]>) in
                deckViews = []
                for d in result.value {
                    deckViews.append(DeckViewModel(title: d.title, icon: d.icon, deck: d))
                }
            }
        })

    }
}

// TODO: rename ViewModels
struct DeckViewModel: Identifiable {
    var id = UUID()
    
    let title: String
    let icon: String
    let deck: Deck
}

extension DeckViewModel: View {
    var body: some View {
        VStack {

            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding()

            Text(deck.description)
                .padding()
                .font(.headline)
                .foregroundColor(.black)
                
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
            
            Text("\(deck.cards.count) Cards")
                .padding()
                .font(.body)
                .foregroundColor(.brown)
        }
        .padding()
        .background(Color.init(white: 0.9))
        .cornerRadius(10)
        .shadow(color: .black, radius: 5, x: 2, y: 2)
    }
}

struct DecksView_Previews: PreviewProvider {
    static var previews: some View {
        DecksView(loggedIn: .constant(true))
    }
}
