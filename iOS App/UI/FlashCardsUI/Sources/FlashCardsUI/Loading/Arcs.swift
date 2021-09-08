//
//  File.swift
//  File
//
//  Created by Diego Freniche Brito on 31/8/21.
//

import SwiftUI

struct ArcView: View {
    @Binding var isAnimating: Bool
    let count: UInt
    let width: CGFloat
    let spacing: CGFloat
    let colors: [Color]

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<Int(count)) { index in
                item(forIndex: index, in: geometry.size)
                    .rotationEffect(isAnimating ? .degrees(360) : .degrees(0))
                    .animation(
                        Animation.default
                            .speed(Double.random(in: 0.2...0.5))
                            .repeatCount(isAnimating ? .max : 1, autoreverses: false)
                    )
                    .foregroundColor(colors[index])
            }
        }
        .aspectRatio(contentMode: .fit)
    }

    private func item(forIndex index: Int, in geometrySize: CGSize) -> some View {
        Group { () -> Path in
            var p = Path()
            p.addArc(center: CGPoint(x: geometrySize.width/2, y: geometrySize.height/2),
                     radius: geometrySize.width/2 - width/2 - CGFloat(index) * (width + spacing),
                     startAngle: .degrees(0),
                     endAngle: .degrees(Double(Int.random(in: 120...300))),
                     clockwise: true)
            return p.strokedPath(.init(lineWidth: width))
        }
        .frame(width: geometrySize.width, height: geometrySize.height)
    }
}

struct ArcView_Previews: PreviewProvider {
    static var previews: some View {
        ArcView(isAnimating: .constant(true), count: 3, width: 15, spacing: 4, colors: [.yellow, .orange, .red])
    }
}
