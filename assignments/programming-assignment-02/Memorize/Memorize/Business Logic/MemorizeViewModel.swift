//
//  MemorizeViewModel.swift
//  Memorize
//
//  Created by Giorgi Beriashvili on 19.09.21.
//

import SwiftUI

extension MemorizeView {
    typealias Model = MemoryGame<String>
    typealias Theme = MemoryGame<String>.Theme<String>
    
    class ViewModel: ObservableObject {
        @Published private(set) var model: Model
        @Published private(set) var theme: Theme
        
        init(emojiTheme: EmojiTheme) {
            let (theme, model) = ViewModel.makeConfiguration(from: emojiTheme)
            
            self.theme = theme
            self.model = model
        }
        
        // MARK: - Getter(s)
        
        var cards: [Model.Card] { model.cards }
        
        var score: Int { model.score }
        
        var cardTheme: AnyShapeStyle {
            switch theme.color {
            case let color where color.contains("-"):
                var colors: [Color] = []
                
                color.split(separator: "-").forEach { color in
                    colors.append(Color.fromString(String(color)))
                }
                
                return AnyShapeStyle(LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing))
            default:
                return AnyShapeStyle(Color.fromString(theme.color))
            }
        }
        
        // MARK: - Intent(s)
        
        func newGame() {
            let emojiTheme = EmojiTheme.allCases.randomElement()!
            let configuration = ViewModel.makeConfiguration(from: emojiTheme)
            
            theme = configuration.theme
            model = configuration.model
        }
        
        func choose(_ card: Model.Card) { model.choose(card) }
    }
}

extension MemorizeView.ViewModel {
    private static func makeConfiguration(from emojiTheme: EmojiTheme) -> (theme: MemorizeView.Theme, model: MemorizeView.Model) {
        let theme = emojiTheme.makeTheme()
        let model = MemoryGame(numberOfPairsOfCards: theme.numberOfPairsOfCards) {
            pairIndex in Array(theme.emojis)[pairIndex]
        }
        
        return (theme, model)
    }
    
    enum EmojiTheme: CaseIterable {
        case animals
        case foods
        case hearts
        case objects
        case vehicles
        case pictographs
        
        func makeTheme() -> MemorizeView.Theme {
            let emojiSet: Set<String>
            
            switch self {
            case .animals:
                emojiSet = ["🐶", "🐱"]
                
                return MemorizeView.Theme(name: "Animals", emojis: emojiSet, numberOfPairsOfCards: 12, color: "blue-purple")
            case .hearts:
                emojiSet = ["❤️", "🧡", "💛", "💚"]
                
                return MemorizeView.Theme(name: "Hearts", emojis: emojiSet, numberOfPairsOfCards: 6, color: "yellow")
            case .pictographs:
                emojiSet = ["☀︎", "☼", "☽", "☾", "☁︎", "☂︎"]
                
                return MemorizeView.Theme(name: "Pictographs", emojis: emojiSet, numberOfPairsOfCards: Int.random(in: 1..<emojiSet.count), color: "purple")
            case .foods:
                emojiSet = [
                    "🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒",
                    "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦", "🥬", "🥒", "🌶",
                ]
                
                return MemorizeView.Theme(name: "Foods", emojis: emojiSet, numberOfPairsOfCards: 3, color: "yellow-red")
            case .objects:
                emojiSet = [
                    "⌚️", "📱", "📲", "💻", "⌨️", "🖥", "🖨", "🖱", "🖲", "🕹", "🗜", "💽",
                    "💾", "💿", "📀", "📼", "📷", "📸", "📹", "🎥", "📽", "🎞", "📞", "☎️",
                ]
                
                return MemorizeView.Theme(name: "Objects", emojis: emojiSet, numberOfPairsOfCards: 6, color: "red")
            case .vehicles:
                emojiSet = [
                    "🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚",
                    "🚛", "🚜", "🛴", "🚲", "🛵", "🏍", "🛺", "🚂", "🚀", "🛸", "🚁", "🛶",
                ]
                
                return MemorizeView.Theme(name: "Vehicles", emojis: emojiSet, color: "orange")
            }
        }
    }
}
