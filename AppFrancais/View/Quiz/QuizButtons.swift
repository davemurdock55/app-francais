//
//  QuizButtons.swift
//  AppFrancais
//
//  Created by David Murdock on 10/25/24.
//

import SwiftUI

struct StartQuizButton: View {
    var goToNextQuestion: () -> Void
    
    var body: some View {
        Button {
            goToNextQuestion()
        } label: {
            HStack {
                Text("Start")
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(.green)
        .foregroundColor(.white)
        .cornerRadius(SharedConstants.cornerRadius)
        .frame(maxWidth: .infinity)
    }
}

struct NextQuestionButton: View {
    var goToNextQuestion: () -> Void
    @Binding var selectedAnswer: String?
    let correctAnswer: String
    @Binding var showCorrectAnswer: Bool
    @State private var buttonScale: CGFloat = Constants.defaultButtonScale
    
    var body: some View {
        Button {
            goToNextQuestion()
        } label: {
            HStack {
                Text("Next").bold()
                Image(systemName: "arrow.forward")
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(selectedAnswer == correctAnswer ? .green : .red)
        .foregroundColor(.white)
        .cornerRadius(SharedConstants.cornerRadius)
        .frame(maxWidth: .infinity)
        .scaleEffect(buttonScale)
        .onAppear {
            withAnimation(.easeIn(duration: Constants.animationDuration)) {
                buttonScale = Constants.enlargedButtonScale
            }
            withAnimation(.easeIn(duration: Constants.animationDuration).delay(Constants.animationDelay)) {
                buttonScale = Constants.defaultButtonScale
            }
        }
    }
}


struct CheckAnswerButton: View {
    var checkAnswer: (String, String) -> Void
    @Binding var selectedAnswer: String?
    let correctAnswer: String
    
    var body: some View {
        Button {
            if let selectedAnswer {
                checkAnswer(selectedAnswer, correctAnswer)
            }
        } label: {
            Label("Check Answer", systemImage: "checkmark.circle.badge.questionmark")
                .bold()
                .frame(maxWidth: .infinity)
        }
        .padding()
        .background((selectedAnswer != nil) ? Color.blue : Color.gray)
        .foregroundColor(.white)
        .cornerRadius(SharedConstants.cornerRadius)
        .opacity(selectedAnswer != nil ? SharedConstants.fullOpacity : SharedConstants.halfOpacity)
        .disabled(selectedAnswer == nil)
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Constants
private struct Constants {
    static let defaultButtonScale = 1.0
    static let enlargedButtonScale = 1.025
    static let animationDuration = 0.1
    static let animationDelay = 0.5
}
