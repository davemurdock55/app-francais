//
//  FlashcardView.swift
//  AppFrancais
//
//  Created by David Murdock on 10/22/24.
//

import SwiftUI

struct FlashcardView: View {
    var vocab: (String, String)
    @State private var isFrenchSide = false
    @State private var cardRotation = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                ZStack {
                    // used AI to learn how to make a drop shadow
                    RoundedRectangle(cornerRadius: SharedConstants.cornerRadius).fill(.white)
                        .shadow(color: Constants.dropShadowColor,
                                radius: Constants.dropShadowRadius,
                                x: Constants.dropShadowX,
                                y: Constants.dropShadowY)
                    Text(isFrenchSide ? vocab.0 : vocab.1)
                        .font(.title)
                        .rotation3DEffect(.degrees(isFrenchSide ? Constants.fullCardFlipAngle : 0), axis: (0, 1, 0))
                }
                .padding()
                .aspectRatio(Constants.aspectRatio, contentMode: .fit)
                .onTapGesture {
                    flipFlashcard()
                }
                .rotation3DEffect(.degrees(cardRotation), axis: (0, 1, 0))
                
                
                Spacer()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        
    }
    
    // used an online tutorial and they used @State with this instead of animateable data (and it works better this way)
    func flipFlashcard() {
        withAnimation(.linear(duration: Constants.animationDuration)) {
            cardRotation += Constants.fullCardFlipAngle
        }
        
        // Figured out how to do a "timeout" using DispatchQueue.main.asyncAfter() from AI
        // Executing this code precisely halfway through the animation ( / 2)
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.animationDuration / 2) {
            isFrenchSide.toggle()
        }
    }
    
    
    // MARK: - Drawing Constants
    private struct Constants {
        static let fullCardFlipAngle: Double = 180
        
        static let aspectRatio: Double = 3/2
        static let animationDuration: Double = 0.29
        
        static let dropShadowColor: Color = Color(red: 0.90, green: 0.90, blue: 0.90)
        static let dropShadowRadius: CGFloat = 5
        static let dropShadowX: CGFloat = 0
        static let dropShadowY: CGFloat = 5
    }
    

}
