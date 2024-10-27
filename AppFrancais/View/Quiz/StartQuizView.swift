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
    @Binding var isTakingQuiz: Bool
    
    var body: some View {
        VStack {
            Text("Quiz \(lesson.num): \(lesson.name)")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.bottom, SharedConstants.standardPadding)
            
            VStack(alignment: .leading) {
                Text("Welcome!")
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading).fontWeight(.semibold)
                Text("This is a timed quiz. The faster you answer questions, the more points you get. But there's a catch, if you don't get all of them right, you don't pass.")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)

            VStack(alignment: .leading) {
                Text("Number of Questions: ").fontWeight(.semibold) + Text("\(questionCount)")
                Text("Number of Points Possible: ").fontWeight(.semibold) + Text("\(questionCount * Constants.totalPossiblePoints)")
                Text("Your High Score: ").fontWeight(.semibold) + Text("\(lesson.highScore)")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, SharedConstants.standardPadding)
            
            Button {
                isTakingQuiz = true
            } label: {
                Label("Start Quiz", systemImage: "play.fill")
                    .frame(maxWidth: .infinity)
            }
            .padding(SharedConstants.standardPadding)
            .background(.green)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .cornerRadius(SharedConstants.cornerRadius)
            .padding(.horizontal)
        }

    }
    
    // MARK: - Constants
    private struct Constants {
        static let totalPossiblePoints: Int = 20
    }
}
