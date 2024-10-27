//
//  QuizScoreView.swift
//  AppFrancais
//
//  Created by David Murdock on 10/25/24.
//

import SwiftUI

struct QuizScoreView: View {
    @EnvironmentObject var lessonViewModel: LessonsViewModel
    var lesson: LessonsModel.Lesson
    @Binding var anyIncorrectAnswers: Bool
    var resetQuiz: () -> Void
    
    var body: some View {      
        VStack {
            
            if !anyIncorrectAnswers {
                VStack {
                    Text("Congratulations!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, SharedConstants.standardPadding)

                    Text("You passed the quiz for Lesson \(lesson.num): \(lesson.name)!")
                        .padding(.horizontal)
                        .padding(.bottom, Constants.bottomPadding)
                }
                
            } else {
                VStack {
                    Text("Better luck next time!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, SharedConstants.standardPadding)
                    Text("Sadly, you didn't pass the quiz for Lesson \(lesson.num): \(lesson.name)!")
                        .padding(.horizontal)
                    Text("Try Again?")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                        .padding(.bottom, Constants.bottomPadding)
                }
            }
            
            Text("Your Score: \(lesson.mostRecentScore)").font(.title).fontWeight(.semibold)
            Text("Your High Score: \(lesson.highScore)").font(.title3)
            
            Button {
                resetQuiz()
            } label: {
                Label("Restart Quiz", systemImage: "arrow.counterclockwise")
            }
            .padding(SharedConstants.standardPadding)
            .background(.blue)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .cornerRadius(SharedConstants.cornerRadius)
        }
    }
    
    // MARK: - Constants
    private struct Constants {
        static let bottomPadding: Double = 25
    }
}
