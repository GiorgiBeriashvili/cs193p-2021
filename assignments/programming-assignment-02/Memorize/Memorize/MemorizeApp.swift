//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Giorgi Beriashvili on 13.09.21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let emojiMemoryGame = MemorizeView.ViewModel(emojiTheme: .allCases.randomElement()!)
    
    var body: some Scene {
        WindowGroup {
            MemorizeView(viewModel: emojiMemoryGame)
        }
    }
}
