//
//  LearnView.swift
//  AppFrancais
//
//  Created by David Murdock on 10/18/24.
//

import SwiftUI

struct LearnView: View {
    @EnvironmentObject var lessonViewModel: LessonsViewModel
    var lesson: LessonsModel.Lesson
    
    var body: some View {
        VStack {
            ScrollView {
                Text("\(lesson.name)").font(.largeTitle)
                
                VStack(alignment: .leading) {
                    Text("\(lesson.learn.lessonText)")
                    
                    Text("Vocab: ").padding(.vertical, 10).fontWeight(.bold).underline()
                    ForEach(lesson.vocabList, id: \.0) { vocab in
                        Text("\(vocab.0)").bold() + Text(" – \(vocab.1)")
                    }
                }.padding()
            }
            
            Spacer()
            
            CompleteButtonView(
                isCompleted: lesson.learn.isLearnCompleted,
                handlePress: { lessonViewModel.handleLearnCompleteTap(num: lesson.num) }
            )
            
        }
    }
    
}


