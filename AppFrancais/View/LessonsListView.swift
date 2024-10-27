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
                        // French Flag
                        HStack {
                            Rectangle()
                                .fill(Color.blue)
                                .frame(height: geometry.size.height / Constants.flagThird)
                            Rectangle()
                                .fill(Color.white)
                                .frame(height: geometry.size.height / Constants.flagThird)
                            Rectangle()
                                .fill(Color.red)
                                .frame(height: geometry.size.height / Constants.flagThird)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: SharedConstants.cornerRadius))
                        Text("Bonjour!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    
                    // List of Lessons
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
                                }.padding(.vertical, Constants.listItemVerticalPadding)
                                
                                Spacer()
                                
                                HStack {
                                    Image(systemName: lesson.isLearnCompleted ? "graduationcap.circle.fill" : "graduationcap.circle")
                                        .font(.system(size: Constants.iconSize))
                                        .foregroundColor(lesson.isLearnCompleted ? .green : .blue)
                                    Image(systemName: lesson.isStudyCompleted ? "rectangle.on.rectangle.circle.fill" : "rectangle.on.rectangle.circle")
                                        .font(.system(size: Constants.iconSize))
                                        .foregroundColor(lesson.isStudyCompleted ? .green : .gray)
                                    Image(systemName: lesson.isQuizCompleted ? "questionmark.circle.fill" : "questionmark.circle")
                                        .font(.system(size: Constants.iconSize))
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

// MARK: - Constants
private struct Constants {
    static let iconSize: Double = 24
    static let flagThird: Double = 3
    static let listItemVerticalPadding: Double = 16
}

#Preview {
    LessonsListView().environmentObject(LessonsViewModel())
}
