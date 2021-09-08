//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 3/9/21.
//

import SwiftUI
import FlashCardsModels
import FlashCardsUseCasesImpl

struct AddCardView: View {
    @Binding var title: String
    @Binding var description: String
    @Binding var icon: String
    @Binding var shouldSave: Bool
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        VStack {
            TextField("Card title", text: $title)
                .modifier(TextFieldStyle())
            
            TextField("Card description", text: $description)
                .modifier(TextFieldStyle())
            
            HStack {
                Image(systemName: icon)
                
                Button(action: {
                    print("Choose icon button pressed...")
                }) {
                    Text("Choose Icon")
                }
            }.padding()
            
            Button(action: {
                guard !title.isEmpty else { return }
                
                shouldSave = true
                mode.wrappedValue.dismiss()
            }) {
                Text("Save!")
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
        }
        .padding()
        .navigationTitle("Add Card")
        
       
    }
}

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardView(title: .constant(""), description: .constant(""), icon: .constant("arrow.down.forward.circle"), shouldSave: .constant(false))
    }
}
