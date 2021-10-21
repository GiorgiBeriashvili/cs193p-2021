//
//  ContentView.swift
//  Memorize
//
//  Created by Giorgi Beriashvili on 13.09.21.
//

import SwiftUI

struct MemorizeView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            HStack {
                Text("Score: \(viewModel.score)")
                Spacer()
                Text("Theme: \(viewModel.theme.name)")
            }
            .padding()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card, theme: viewModel.cardTheme)
                            .aspectRatio(2 / 3, contentMode: .fit)
                            .onTapGesture { viewModel.choose(card) }
                    }
                }
            }
            Spacer()
            HStack {
                Image(systemName: "plus.circle")
                Text("New Game")
            }
            .font(.largeTitle)
            .onTapGesture { viewModel.newGame() }
            .padding()
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let emojiMemoryGame = MemorizeView.ViewModel(emojiTheme: .foods)

        MemorizeView(viewModel: emojiMemoryGame)
            .preferredColorScheme(.dark)
        MemorizeView(viewModel: emojiMemoryGame)
            .preferredColorScheme(.light)
    }
}
