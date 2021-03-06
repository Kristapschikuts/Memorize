//
//  EmojiMemoryGameChooser.swift
//  Memorize
//
//  Created by kristaps.cikuts on 23/04/2021.
//

import SwiftUI

struct EmojiMemoryGameChooser: View {
    @EnvironmentObject var store: EmojiMemoryGameStore
    
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.emojiMemoryGames) { emojiMemoryGame in
                    NavigationLink(destination: EmojiMemoryGameView(emojiMemoryGame: emojiMemoryGame)
                        .navigationBarTitle(emojiMemoryGame.themeName)
                    ) {
                        EditableThemeListItem(theme: emojiMemoryGame.theme, isEditing: self.editMode.isEditing)
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        self.store.remove(at: index)
                    }
                }
            }
            .navigationBarTitle(self.store.name)
            .navigationBarItems(
                leading: Button(
                    action: { self.store.add() },
                    label: { Image(systemName: "plus").imageScale(.large) }
                ),
                trailing: EditButton()
            )
            .environment(\.editMode, $editMode)
        }
    }
}

struct EmojiMemoryGameChooser_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameChooser()
    }
}
