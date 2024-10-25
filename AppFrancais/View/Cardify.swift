//
//  Cardify.swift
//  AppFrancais
//
//  Created by David Murdock on 10/22/24.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFrenchSide: Bool {
        rotation < 0
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var rotation: Double
    
    init(isFrenchSide: Bool) {
        rotation = isFrenchSide ? 180 : 0
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(.white)
                    .shadow(color: Constants.dropShadowColor,
                            radius: Constants.dropShadowRadius,
                            x: Constants.dropShadowX,
                            y: Constants.dropShadowY)
//                if isFrenchSide {
//                    content
//                        .rotation3DEffect(Angle.degrees(180), axis: (0, 1, 0))
//                } else {
//                    content
//                        .rotation3DEffect(Angle.degrees(0), axis: (0, 1, 0))
//                }
                
                content
                    .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
            }
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    
    // MARK: - Drawing Constants
    private struct Constants {
        static let dropShadowColor: Color = Color(red: 0.90, green: 0.90, blue: 0.90)
        static let dropShadowRadius: CGFloat = 5
        static let dropShadowX: CGFloat = 0
        static let dropShadowY: CGFloat = 5
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFrenchSide: isFaceUp))
    }
}
