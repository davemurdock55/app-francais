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
            Text("You \(!anyIncorrectAnswers ? "finished" : "failed") the quiz for Lesson \(lesson.num): \(lesson.name)!")
                .padding()
            
            Text("Your Score: \(lesson.mostRecentScore)").font(.title).fontWeight(.semibold)
            Text("Your High Score: \(lesson.highScore)").font(.title3)
            
            Button {
                resetQuiz()
            } label: {
                Label("Restart Quiz", systemImage: "arrow.counterclockwise")
                
            }
            .padding(15)
            .background(.blue)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .cornerRadius(SharedConstants.cornerRadius)
            
            Spacer()
            
            if !anyIncorrectAnswers || lesson.isQuizCompleted {
                CompleteButtonView(
                    activity: "Quiz",
                    isCompleted: lesson.isQuizCompleted,
                    handlePress: { lessonViewModel.handleQuizCompleteTap(for: lesson.num) }
                )
            }
        }
    }
}
