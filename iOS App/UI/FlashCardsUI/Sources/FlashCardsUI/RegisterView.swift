//
//  SwiftUIView.swift
//  SwiftUIView
//
//  Created by Diego Freniche Brito on 1/9/21.
//

import SwiftUI
import FlashCardsModels
import FlashCardsUseCases

struct RegisterView: View {
    @State private var user: String = ""
    @State private var password: String = ""
    @State var registerAction: (UserCredentials) -> Void
    
    var body: some View {
        VStack {

            Text("Register")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            TextField("User", text: $user)
                .modifier(TextFieldStyle())
            SecureField("Password", text: $password)
                .modifier(TextFieldStyle())
            SecureField("Repeat Password", text: $password)
                .modifier(TextFieldStyle())
                .padding(.bottom, 40.0)
            
            Button("Register!") {
//                registerAction(FlashCardsUserCredentials())
            }
            .font(.title)
            .padding(.horizontal, 90)
            .padding(.vertical, 20)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(15.0)

        }.padding()
    }
}

//struct RegisterView_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        RegisterView(user: "", password: "") { _ in }
//        RegisterView() { _ in }
//    }
//}
