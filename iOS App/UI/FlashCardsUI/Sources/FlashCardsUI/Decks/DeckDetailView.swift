//
//  SwiftUIView.swift
//  SwiftUIView
//
//  Created by Diego Freniche Brito on 31/8/21.
//

import SwiftUI
import FlashCardsModels
import FlashCardsUseCases
import FlashCardsUseCasesImpl
import FlashCardsRepositoriesRealmImpl

struct DeckDetailView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var newCardTitle: String = ""
    @State var newCardDescription: String = ""
    @State var newCardIcon: String = ""
    
    @State var shouldSave: Bool = false
    
    @State var deck: Deck
    @State var cardViews: [CardViewModel] = []
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(cardViews) { card in
                    NavigationLink(destination: CardsView(card: card.card as! FlashCard)) {
                        card
                    }
                }
            }
            
            Button(action: {    // Delete card
                print("Delete button pressed...")
                
                DeleteDeckUseCaseImpl(decksRepository: DeckRepositoryRealmImpl()).execute(data: deck) { (result: UseCaseResult<Bool>) in
                    print("Deleted deck")
                }
            }) {
                Text("Delete")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.red)
            .cornerRadius(10)
        }
        .padding()
        // Navigation Bar
        .navigationTitle(deck.title)
        .navigationBarItems(trailing:
            NavigationLink(destination: AddCardView(title: $newCardTitle,
                                                    description: $newCardDescription,
                                                    icon: $newCardIcon,
                                                    shouldSave: $shouldSave)) {
                    Text("Add")
            }
        )
        // Loading code
        .onAppear {
            if shouldSave {
                let card = FlashCard(title: newCardTitle, description: newCardDescription, icon: newCardIcon, creationDate: Date(), lastUpdateDate: Date())

                let addCardUseCase = AddCardUseCaseImpl(deck: deck,
                                                        decksRepository: DeckRepositoryRealmImpl(),
                                                        deckToDeckEntityMapper: DeckToDeckRealmEntityMapper(),
                                                        cardToCardEntityMapper: CardToCardRealmEntityMapper())
                
                addCardUseCase.execute(data: card) { (result: UseCaseResult<Bool>) in
                    shouldSave = false
                    newCardTitle = ""
                    newCardDescription = ""
                    newCardIcon = ""
                    
                    deck = FlashCardDeck.from(deck: deck, addingCard: card)

                    refresh()
                }
                
            }
            
            refresh()
        }
    }
}

extension DeckDetailView {
    func refresh() {
        self.cardViews = deck.cards.map { CardViewModel(title: $0.title, icon: $0.icon, card: $0) }
    }
}

struct CardViewModel: Identifiable {
    var id = UUID()
    
    let title: String
    let icon: String
    let card: Card
}

extension CardViewModel: View {
    var body: some View {
        Group {
            VStack {
                VStack {
                    Label(title, image: icon)
                        .lineLimit(1)
                        .font(.title)
                        .foregroundColor(.white)
                        .shadow(color: Color.black, radius: 0, x: 0, y: 0)
                    
                    Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .shadow(color: Color.white, radius: 1, x: 1, y: 1)
                }
            }
            .padding()
        }
        .background(Color.gray)
        .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        .cornerRadius(5)
    }
}

struct DeckDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DeckDetailView(deck: FlashCardDeck(title: "Title Deck", description: "Deck Desc", icon: "arrow.down.forward.circle", creationDate: Date(), lastUpdateDate: Date(), cards: [
            FlashCard(title: "Test", description: "Something", icon: "arrow.down.forward.circle", creationDate: Date(), lastUpdateDate: Date()),
            FlashCard(title: "Test", description: "Something", icon: "arrow.down.forward.circle", creationDate: Date(), lastUpdateDate: Date())
            ]))
    }
}
