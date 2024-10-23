//
//  StudyView.swift
//  AppFrancais
//
//  Created by David Murdock on 10/18/24.
//

import SwiftUI


struct StudyView: View {
    @EnvironmentObject var lessonViewModel: LessonsViewModel
    var lesson: LessonsModel.Lesson
   
    var body: some View {
        VStack {
            Text("Study!")
            
            
            
            Spacer()
            
//            CompleteButtonView(
//                isCompleted: lesson.study.isStudyCompleted,
//                handlePress: { lessonViewModel.handleStudyCompleteTap(num: lesson.num) }
//            )
        }
    }
}
