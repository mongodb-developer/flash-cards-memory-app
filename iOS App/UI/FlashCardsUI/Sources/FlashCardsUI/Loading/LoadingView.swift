//
//  SwiftUIView.swift
//  SwiftUIView
//
//  Created by Diego Freniche Brito on 31/8/21.
//

import SwiftUI

struct LoadingView: View {
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.black)
                .padding()
                
            
            ArcView(isAnimating: .constant(true), count: 3, width: 15, spacing: 5, colors: [.yellow, .orange, .red])
                
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(title: "Hello")
    }
}
