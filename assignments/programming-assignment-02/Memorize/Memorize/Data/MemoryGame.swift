//
//  MemoryGame.swift
//  Memorize
//
//  Created by Giorgi Beriashvili on 19.09.21.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    struct Card: Identifiable {
        var id: Int
        var content: CardContent
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isPreviouslySeen = false
        var seenDate: Date?
    }
    
    private(set) var cards: [Card]
    private(set) var score = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [Card]()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        
        cards = cards.shuffled()
    }
    
    private func timeSinceLastSeen(of card: Card) -> Int {
        if let cardSeenDate = card.seenDate {
            return Int(cardSeenDate.distance(to: Date.now))
        } else {
            return 0
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    
                    score += min(
                        max(10 - timeSinceLastSeen(of: cards[chosenIndex]), 2),
                        max(10 - timeSinceLastSeen(of: cards[potentialMatchIndex]), 2)
                    )
                } else {
                    if cards[chosenIndex].isPreviouslySeen {
                        score -= max(10 - timeSinceLastSeen(of: cards[chosenIndex]), 1)
                    }
                    
                    if cards[potentialMatchIndex].isPreviouslySeen {
                        score -= max(10 - timeSinceLastSeen(of: cards[chosenIndex]), 1)
                    }
                    
                    cards[chosenIndex].isPreviouslySeen = true
                    cards[potentialMatchIndex].isPreviouslySeen = true
                }
                
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
            cards[chosenIndex].seenDate = Date.now
        }
    }
}

extension MemoryGame {
    struct Theme<T: Hashable> {
        let name: String
        let emojis: Set<T>
        let numberOfPairsOfCards: Int
        let color: String
        
        init(name: String, emojis: Set<T>, color: String) {
            self.name = name
            self.emojis = emojis
            self.numberOfPairsOfCards = emojis.count
            self.color = color
        }
        
        init(name: String, emojis: Set<T>, numberOfPairsOfCards: Int, color: String) {
            self.name = name
            self.emojis = emojis
            self.color = color
            
            if numberOfPairsOfCards > emojis.count {
                self.numberOfPairsOfCards = emojis.count
            } else {
                self.numberOfPairsOfCards = numberOfPairsOfCards
            }
        }
    }
}
