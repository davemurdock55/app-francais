//
//  LessonsListView.swift
//  AppFrancais
//
//  Created by David Murdock on 10/10/24.
//

import SwiftUI

struct LessonsListView: View {
    @EnvironmentObject var lessonsViewModel: LessonsViewModel
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack {
                    ZStack {
                        HStack {
                            Rectangle()
                                .fill(Color.blue)
                                .frame(height: geometry.size.height / 3)
                            Rectangle()
                                .fill(Color.white)
                                .frame(height: geometry.size.height / 3)
                            Rectangle()
                                .fill(Color.red)
                                .frame(height: geometry.size.height / 3)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        Text("Bonjour!")
//                            .foregroundColor(.black)
                            .font(.largeTitle)
//                            .font(.system(size: 45)) // did get font size from AI
//                            .foregroundColor(Color(red: 0, green: 0, blue: 0.5))
                            .fontWeight(.bold)
                    }
                    
                    List(lessonsViewModel.lessons, id: \.self.num) { lesson in
                        // had some help from the AI to get the NavigationLink working properly (and a bit of the inside stuff)
                        NavigationLink(destination: LessonContentView(lesson: lesson)) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Lesson \(lesson.num)")
                                        .font(.headline)
                                    Text(lesson.name)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }.padding(.vertical, 16)
                                
                                Spacer()
                                
                                HStack {
                                    Image(systemName: lesson.isLearnCompleted ? "graduationcap.circle.fill" : "graduationcap.circle")
                                        .font(.system(size: 24))
                                        .foregroundColor(lesson.isLearnCompleted ? .green : .blue)
                                    Image(systemName: lesson.isStudyCompleted ? "rectangle.on.rectangle.circle.fill" : "rectangle.on.rectangle.circle")
                                        .font(.system(size: 24))
                                        .foregroundColor(lesson.isStudyCompleted ? .green : .gray)
                                    Image(systemName: lesson.isQuizCompleted ? "questionmark.circle.fill" : "questionmark.circle")
                                        .font(.system(size: 24))
                                        .foregroundColor(lesson.isQuizCompleted ? .green : .red)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                }
                .padding()
            }
        }
    }
}

#Preview {
    LessonsListView().environmentObject(LessonsViewModel())
}
