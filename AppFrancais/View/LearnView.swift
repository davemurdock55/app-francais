//
//  LearnView.swift
//  AppFrancais
//
//  Created by David Murdock on 10/18/24.
//

import SwiftUI


struct LearnView: View {
    
//    @Bindable var lesson: LessonsModel.Lesson
    @EnvironmentObject var lessonViewModel: LessonsViewModel
    var lesson: LessonsModel.Lesson
    
    var body: some View {
        VStack {
            Text("\(lesson.learn.lessonText)")
            Text("Learn Completed? \(lesson.learn.isLearnCompleted)")
            
            CompleteButtonView(
                isCompleted: lesson.learn.isLearnCompleted,
                handlePress: { lessonViewModel.handleLearnCompleteTap(num: lesson.num) }
            )
//            Button {
//                lessonViewModel.handleLearnCompleteTap(num: lesson.num)
//            } label: {
//                !lesson.learn.isLearnCompleted ? Label("MARK AS COMPLETE", systemImage: "checkmark.circle") : Label("MARK AS INCOMPLETE", systemImage: "checkmark.circle")
//            }
//            .padding()
//            .background(!lesson.learn.isLearnCompleted ? Color.green : Color.gray)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//            .opacity(!lesson.learn.isLearnCompleted ? 1.0 : 0.5)
        }
       
    }
}


