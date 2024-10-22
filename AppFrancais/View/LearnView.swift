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
            
            Button {
                lessonViewModel.handleLearnCompleteTap(num: lesson.num)
            } label: {
                !lesson.learn.isLearnCompleted ? Label("Complete", systemImage: "checkmark.circle") : Label("UnComplete", systemImage: "checkmark.circle")
            }
        }
       
    }
}


