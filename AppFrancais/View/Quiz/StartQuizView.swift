//
//  StartQuizView.swift
//  AppFrancais
//
//  Created by David Murdock on 10/26/24.
//

import SwiftUI

struct StartQuizView: View {
    @EnvironmentObject var lessonViewModel: LessonsViewModel
    var lesson: LessonsModel.Lesson
    
    var questionCount: Int
    
    var body: some View {
        VStack {
            Text("Quiz \(lesson.num)").font(.title).fontWeight(.semibold)
            
            Text("Welcome to the quiz for \(lesson.name)!")
                .padding()
            Text("This is a timed quiz. The faster you answer questions, the more points you get. However, if you don't get all of them right, you don't pass.")
                .padding()
            
            Text("Number of Questions: \(questionCount)")
            Text("Number of Points Possible: \(questionCount * 20)")
            
            Text("Your High Score: \(lesson.highScore)").font(.title3)
            
            Button {
                
            } label: {
                Label("Start Quiz", systemImage: "arrow.counterclockwise")
                
            }
            .padding(15)
            .background(.blue)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .cornerRadius(SharedConstants.cornerRadius)
            
            Spacer()
            
            if lesson.isQuizCompleted {
                CompleteButtonView(
                    activity: "Quiz",
                    isCompleted: lesson.isQuizCompleted,
                    handlePress: { lessonViewModel.handleQuizCompleteTap(for: lesson.num) }
                )
            }
        }
    }
}
