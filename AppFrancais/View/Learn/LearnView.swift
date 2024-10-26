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
//                Text("\(lesson.name)").font(.largeTitle)
                HStack {
                    Image(systemName: "graduationcap.circle")
                        .foregroundColor(!lesson.isLearnCompleted ? .blue : .green)
                    Text("Learn")
                }.font(.title)
                
                VStack(alignment: .leading) {
                    Text("\(lesson.lessonText)")
                    
                    Text("Vocab: ").padding(.vertical, 10).fontWeight(.bold).underline()
                    ForEach(lesson.vocabList, id: \.0) { vocab in
                        Text("\(vocab.0)").bold() + Text(" – \(vocab.1)")
                    }
                }.padding()
            }
            
            Spacer()
            
            CompleteButtonView(
                activity: "Learn",
                isCompleted: lesson.isLearnCompleted,
                handlePress: { lessonViewModel.handleLearnCompleteTap(for: lesson.num) }
            )
            
        }
    }
    
}


