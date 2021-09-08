//
//  SwiftUIView.swift
//  SwiftUIView
//
//  Created by Diego Freniche Brito on 24/8/21.
//

import SwiftUI

struct LoginView: View {
    @State var user: String
    @State var password: String
    @State var loginAction: (String, String) -> Void

    var body: some View {
        VStack {
            Text("記憶")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding()
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            TextField("User", text: $user)
                .modifier(TextFieldStyle())
            SecureField("Password", text: $password)
                .modifier(TextFieldStyle())
                .padding(.bottom, 40.0)
            
            Button("Login!") {
                loginAction(user, password)
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

struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
        .padding()
        .font(.body)
        .border(Color.gray, width: 1.0)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(user: "", password: "") {_,_ in
            print("Hello")
        }
    }
}

 
