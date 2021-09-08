//
//  SwiftUIView.swift
//  SwiftUIView
//
//  Created by Diego Freniche Brito on 31/8/21.
//

import SwiftUI
import FlashCardsUseCasesImpl

struct CardsView: View {
    let card: FlashCard
    
    var body: some View {
        Group{
            VStack {
                Image(systemName: card.icon)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .padding()
                Text(card.title)
                    .font(.largeTitle)
                    .shadow(color: .black, radius: 0, x: 0, y: 0)
                
                Spacer()
                
                Text(card.description)
                    .font(.title)
                Spacer()
            }
            .padding()
            .background(Color.gray)
            .shadow(color: Color.black, radius: 2, x: 2, y: 2)
        }.padding()
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView(card: FlashCard(title: "Card Title", description: "Card Description", icon: "arrow.down.forward.circle", creationDate: Date(), lastUpdateDate: Date()))
    }
}
