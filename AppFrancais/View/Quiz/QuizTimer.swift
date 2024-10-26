//
//  QuizTimer.swift
//  AppFrancais
//
//  Created by David Murdock on 10/25/24.
//

import SwiftUI

struct QuizTimer: View {
//    var timeRemaining: Double
//    var timer: Timer?
    @Binding var timeRemaining: Double
    
    // I used AI to build a lot of this timer
    
    var body: some View {
//        Circle().frame(width: 100).foregroundStyle(.blue)
        ZStack {
            Circle()
                .stroke(lineWidth: 10.0)
                .opacity(0.1)
                .foregroundColor(.gray)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(timeRemaining / 10.0, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(timeRemaining >= 5 ? .blue : .red)
                .rotationEffect(Angle(degrees: 270.0))

            Text(String(format: "%.0f", timeRemaining > 0.01 ? ceil(timeRemaining) : 0))
                .font(.title)
                .fontWeight(.semibold)
                .animation(nil)
        }
        .frame(width: 100, height: 100)
    }

}
