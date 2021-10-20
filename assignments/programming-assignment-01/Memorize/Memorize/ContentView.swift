//
//  ContentView.swift
//  Memorize
//
//  Created by Giorgi Beriashvili on 11.10.21.
//

import SwiftUI

struct CardView: View {
    var content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content)
                    .font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct NavigationButton: View {
    var icon: String
    var description: String
    var onTap: () -> Void
    
    var body: some View {
        VStack {
            Button {
                onTap()
            } label: {
                VStack {
                    Image(systemName: icon)
                        .font(.largeTitle)
                    Text(description)
                        .font(.caption2)
                }
            }
        }
    }
}

struct BottomNavigationBar<Content: View>: View {
    var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HStack {
            content
        }
        .font(.largeTitle)
        .padding(.horizontal)
    }
}

enum EmojiSet: CaseIterable {
    case foods
    case objects
    case vehicles
    
    func makeEmojis() -> [String] {
        switch self {
        case .foods:
            return [
                "🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒",
            ]
        case .objects:
            return [
                "⌚️", "📱", "📲", "💻", "⌨️", "🖥", "🖨", "🖱", "🖲", "🕹", "🗜", "💽",
                "💾", "💿", "📀", "📼", "📷", "📸",
            ]
        case .vehicles:
            return [
                "🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚",
                "🚛", "🚜", "🛴", "🚲", "🛵", "🏍", "🛺", "🚂", "🚀", "🛸", "🚁", "🛶",
            ]
        }
    }
}

struct ContentView: View {
    @State var emojis: [String]
    
    init() {
        if let emojiSet = EmojiSet.allCases.randomElement() {
            emojis = emojiSet.makeEmojis()
        } else {
            emojis = EmojiSet.foods.makeEmojis()
        }
    }
    
    init(startingEmojiSet: EmojiSet) {
        emojis = startingEmojiSet.makeEmojis()
    }
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(emojis[0..<emojis.count], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            BottomNavigationBar {
                Spacer()
                NavigationButton(icon: "applelogo", description: "Foods") {
                    emojis = EmojiSet.foods.makeEmojis().shuffled()
                }
                Spacer()
                NavigationButton(icon: "laptopcomputer", description: "Objects") {
                    emojis = EmojiSet.objects.makeEmojis().shuffled()
                }
                Spacer()
                NavigationButton(icon: "car", description: "Vehicles") {
                    emojis = EmojiSet.vehicles.makeEmojis().shuffled()
                }
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(startingEmojiSet: EmojiSet.foods)
            .preferredColorScheme(.dark)
        ContentView(startingEmojiSet: EmojiSet.foods)
            .preferredColorScheme(.light)
    }
}
