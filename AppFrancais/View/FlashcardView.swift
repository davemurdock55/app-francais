//
//  FlashcardView.swift
//  AppFrancais
//
//  Created by David Murdock on 10/22/24.
//

import SwiftUI

struct FlashcardView: View {
    var vocab: (String, String)
    @State private var isShowingDefinition = false
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                if isShowingDefinition {
                    Text(vocab.0)
//                        .font(systemFont(for: geometry.size))
                        .font(.title)
                } else {
                    Text(vocab.1)
//                        .font(systemFont(for: geometry.size))
                        .font(.title)
                }
            }
            .cardify(isFaceUp: isShowingDefinition)
            
        }
        .aspectRatio(Constants.aspectRatio, contentMode: .fit)
        .onTapGesture {
            isShowingDefinition.toggle()
        }
    }
    
    // MARK: - Drawing Constants
    private struct Constants {
        static let aspectRatio: Double = 3/2
        static let cornerRadius: Double = 10
        static let fontScaleFactor: Double = 0.75
    }
    
    private func systemFont(for size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * Constants.fontScaleFactor)
    }
}
