//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by kristaps.cikuts on 31/03/2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    init(emojiMemoryGame: EmojiMemoryGame) {
        self.viewModel = emojiMemoryGame
    }
    
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        self.viewModel.choose(card: card)
                    }
                }
                    .padding(5)
            }
                .padding()
                .foregroundColor(viewModel.themeColor)
            
            HStack {
                Spacer()
                Text("Score: \(viewModel.score)")
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.75)) {
                        self.viewModel.resetGame()
                    }
                }, label: { Text("New Game")})
                Spacer()
            }
                .font(Font.headline)
            
            
        }
            .padding([.bottom, .leading, .trailing])
            .foregroundColor(viewModel.themeColor)
        
    }
    
    // MARK: - Drawing Constants
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                    .padding(5).opacity(0.4)
                    .transition(.identity)

                Text(self.card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 0.75 ).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    // MARK: - Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let store = EmojiMemoryGameStore()
        return EmojiMemoryGameView(emojiMemoryGame: store.emojiMemoryGames[0])
    }
}
