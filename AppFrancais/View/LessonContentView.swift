//
//  LessonContentView.swift
//  AppFrancais
//
//  Created by David Murdock on 10/18/24.
//
import SwiftUI

struct LessonContentView: View {
    var lesson: LessonsModel.Lesson
    
    @State private var selectedTab = 0
    
    
    
    var body: some View {
            VStack {
                // did learn how to use the tags better thanks to AI
                Picker("Select a tab", selection: $selectedTab) {
                    Text("Learn").tag(0)
                    Text("Study").tag(1)
                    Text("Quiz").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Spacer()
                
                TabView(selection: $selectedTab) {
                    LearnView(lesson: lesson)
                        .tag(0)
                    StudyView(lesson: lesson)
                        .tag(1)
                    QuizView(lesson: lesson)
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .navigationTitle(lesson.name)
    }
}
