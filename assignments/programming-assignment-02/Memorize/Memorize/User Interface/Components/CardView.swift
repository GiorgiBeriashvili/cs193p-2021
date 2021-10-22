//
//  CardView.swift
//  Memorize
//
//  Created by Giorgi Beriashvili on 21.10.21.
//

import SwiftUI

struct CardView: View {
    let card: MemorizeView.Model.Card
    let theme: AnyShapeStyle
    
    private struct Constants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.75
    }
    
    private func fontSize(in size: CGSize) -> CGFloat {
        min(size.height, size.width) * Constants.fontScale
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
                
                if card.isMatched {
                    shape.opacity(0)
                } else if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(theme, lineWidth: Constants.lineWidth)
                    Text(card.content).font(.system(size: fontSize(in: geometry.size)))
                } else {
                    shape.fill(theme)
                }
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let theme = LinearGradient(
            gradient: Gradient(colors: [.blue, .purple]),
            startPoint: .leading,
            endPoint: .trailing
        )
        
        HStack {
            CardView(
                card: MemorizeView.Model.Card(
                    id: 1,
                    content: "♠️",
                    isFaceUp: true,
                    isMatched: false,
                    isPreviouslySeen: false,
                    seenDate: nil
                ),
                theme: AnyShapeStyle(theme)
            )
            CardView(
                card: MemorizeView.Model.Card(id: 1, content: "♠️"),
                theme: AnyShapeStyle(theme)
            )
        }
        .frame(width: 150 * 2, height: 225)
    }
}
