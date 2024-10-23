//
//  Cardify.swift
//  AppFrancais
//
//  Created by David Murdock on 10/22/24.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(.white)
                    .shadow(color: Constants.dropShadowColor,
                            radius: Constants.dropShadowRadius,
                            x: Constants.dropShadowX,
                            y: Constants.dropShadowY)
                content
            }
        }
    }
    
    
    // MARK: - Drawing Constants
    private struct Constants {
        static let dropShadowColor: Color = Color(red: 0.90, green: 0.90, blue: 0.90)
        static let dropShadowRadius: CGFloat = 5
        static let dropShadowX: CGFloat = 0
        static let dropShadowY: CGFloat = 5
    }
    
    
//    private func cornerRadius(for size: CGSize) -> Double {
//        min(size.width, size.height) * 0.08
//    }

}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
