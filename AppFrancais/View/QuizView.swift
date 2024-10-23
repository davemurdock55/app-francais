//
//  QuizView.swift
//  AppFrancais
//
//  Created by David Murdock on 10/18/24.
//

import SwiftUI


struct QuizView: View {
    @EnvironmentObject var lessonViewModel: LessonsViewModel
    var lesson: LessonsModel.Lesson
   
    var body: some View {
        VStack {
            Text("\(lesson.name)").font(.largeTitle)
            Text("Quiz")
            Spacer()
            
//            CompleteButtonView(
//                isCompleted: lesson.quiz.isQuizCompleted,
//                handlePress: { lessonViewModel.handleQuizCompleteTap(num: lesson.num) }
//            )
        }
    }
}
