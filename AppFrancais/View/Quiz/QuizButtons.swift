//
//  QuizButtons.swift
//  AppFrancais
//
//  Created by David Murdock on 10/25/24.
//

import SwiftUI

struct StartQuizButton: View {
//    @EnvironmentObject var lessonViewModel: LessonsViewModel
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
//    @EnvironmentObject var lessonViewModel: LessonsViewModel
    var goToNextQuestion: () -> Void
    @Binding var selectedAnswer: String?
    let correctAnswer: String
    
    var body: some View {
        Button {
            goToNextQuestion()
        } label: {
            HStack {
                Text("Next")
                Image(systemName: "arrow.forward")
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(selectedAnswer == correctAnswer ? .green : .red)
        .foregroundColor(.white)
        .cornerRadius(SharedConstants.cornerRadius)
        .frame(maxWidth: .infinity)
    }
}


struct CheckAnswerButton: View {
//    @EnvironmentObject var lessonViewModel: LessonsViewModel
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
                .frame(maxWidth: .infinity)
//                                Text("Check Answer")
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
