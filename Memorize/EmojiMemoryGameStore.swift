//
//  EmojiMemoryGameStore.swift
//  Memorize
//
//  Created by kristaps.cikuts on 23/04/2021.
//

import SwiftUI
import Combine

class EmojiMemoryGameStore: ObservableObject {
    let name: String
    
    private static let themesKey = "EmojiMemoryGameStore.ThemesKey"
    
    private var autosave: AnyCancellable?
    
    init(named name: String = "Memorize") {
        self.name = name
        let defaultsKey = "EmojiMemoryGameStore.\(name)"
        emojiMemoryGames = Array(fromPropertyList: UserDefaults.standard.object(forKey: defaultsKey)) ?? []
        autosave = $emojiMemoryGames.sink { emojiMemoryGames in
            UserDefaults.standard.set(emojiMemoryGames.asPropertyList, forKey: defaultsKey)
        }
        
        if emojiMemoryGames.count == 0 {
            addThemes([
                Theme(name: "Halloween", emojis: ["π§ββοΈ", "π", "π·", "π»", "π¦"], color: UIColor.systemOrange, numOfEmojis: 5),
                Theme(name: "Christmas", emojis: ["π", "π€Ά", "π", "π", "βοΈ", "βοΈ"], color: UIColor.systemBlue, numOfEmojis: 6),
                Theme(name: "Summer", emojis: ["βοΈ", "πΆ", "π₯΅", "π", "π", "β±", "π", "π"], color: UIColor.systemYellow, numOfEmojis: 8),
                Theme(name: "Sports", emojis: ["β½οΈ", "π", "πββοΈ", "πΎ", "πΏ", "π", "π", "π", "π", "π", "π", "π", "πΈ", "πΉ", "βΎοΈ", "β³οΈ", "π₯", "π₯", "β·", "βΈ", "π"], color: UIColor.systemGreen, numOfEmojis: 10),
                Theme(name: "Music", emojis: ["πΈ", "π§", "πΉ", "π€", "πΊ", "π»", "πΌ", "πͺ", "π·", "π₯", "πΆ", "π΅", "π©βπ€", "π¨βπ€"], color: UIColor.systemRed, numOfEmojis: 10),
                Theme(name: "Flags", emojis: ["π±π»", "π±πΉ", "π«π·", "π¨π¦", "πΊπΈ", "π¨π³", "πͺπͺ", "π¬π§"], color: UIColor.systemGray, numOfEmojis: 8),
            ])
        }
    }
    
    @Published var emojiMemoryGames: [EmojiMemoryGame]
    
    func add() {
        emojiMemoryGames.append(EmojiMemoryGame())
    }
    
    @discardableResult
    func remove(at index: Int) -> EmojiMemoryGame {
        return emojiMemoryGames.remove(at: index)
    }
    
    func remove(emojiMemoryGame: EmojiMemoryGame) -> Bool {
        if let index = emojiMemoryGames.firstIndex(matching: emojiMemoryGame) {
            emojiMemoryGames.remove(at: index)
            return true
        }
        return false
    }
    
    func addThemes(_ themes: [Theme]) {
        for theme in themes {
            addTheme(theme)
        }
    }

    func addTheme(_ theme: Theme) {
        emojiMemoryGames.append(EmojiMemoryGame(theme: theme))
    }
    
    func reset(theme: Theme) {
        if let index = emojiMemoryGames.firstIndex(where: { emojiMemoryGame in emojiMemoryGame.theme == theme }) {
            emojiMemoryGames[index].resetGame()
        }
    }
}

extension Array where Element == EmojiMemoryGame {
    var asPropertyList: [String] {
        var uuidStrings = [String]()
        for emojiMemorygame in self {
            uuidStrings.append(emojiMemorygame.id.uuidString)
        }
        return uuidStrings
    }
    
    init?(fromPropertyList plist: Any?) {
        self.init()
        let uuidStrings = plist as? [String] ?? [String]()
        for uuidString in uuidStrings {
            self.append(EmojiMemoryGame(id: UUID(uuidString: uuidString)))
        }
    }
}
