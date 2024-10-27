//
//  QuizTimer.swift
//  AppFrancais
//
//  Created by David Murdock on 10/25/24.
//

import SwiftUI

struct QuizTimer: View {
    @Binding var timeRemaining: Double
    
    // I used AI to build a lot of this timer (but I made it a bit more of my own as we went)
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: Constants.strokeWidth)
                .opacity(Constants.backgroundCircleOpacity)
                .foregroundColor(.gray)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(timeRemaining / Constants.totalTime, Constants.fullCirclePercent)))
                .stroke(style: StrokeStyle(lineWidth: Constants.strokeWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(timeRemaining >= Constants.dangerZoneCutoff ? .blue : .red)
                .rotationEffect(Angle(degrees: 270.0))

            Text(String(format: "%.0f", timeRemaining > Constants.timerEndCutoff ? ceil(timeRemaining) : 0))
                .font(.title)
                .fontWeight(.semibold)
                .animation(nil)
        }
        .frame(width: Constants.timerWidth, height: Constants.timerHeight)
    }
    
    // MARK: - Constants
    private struct Constants {
        static let strokeWidth: Double = 10.0
        static let backgroundCircleOpacity: Double = 0.1
        static let totalTime: Double = 10.0
        static let fullCirclePercent: Double = 1.0
        static let dangerZoneCutoff: Double = 5.0
        static let timerEndCutoff: Double = 0.01
        static let timerWidth: Double = 100
        static let timerHeight: Double = 100
    }
}
