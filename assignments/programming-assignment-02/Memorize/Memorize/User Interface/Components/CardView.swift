//
//  CardView.swift
//  Memorize
//
//  Created by Giorgi Beriashvili on 21.10.21.
//

import SwiftUI

struct CardView: View {
    let card: MemoryGame<String>.Card
    let theme: AnyShapeStyle
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if card.isMatched {
                shape.opacity(0)
            } else if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(theme, lineWidth: 3)
                Text(card.content)
                    .font(.largeTitle)
            } else {
                shape.fill(theme)
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
                card: MemoryGame.Card(
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
                card: MemoryGame.Card(id: 1, content: "♠️"),
                theme: AnyShapeStyle(theme)
            )
        }
        .frame(width: 150 * 2, height: 225)
    }
}
