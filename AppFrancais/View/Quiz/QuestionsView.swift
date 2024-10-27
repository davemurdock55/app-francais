//
//  QuestionsView.swift
//  AppFrancais
//
//  Created by David Murdock on 10/25/24.
//

import SwiftUI

struct QuestionsView: View {
    var lesson: LessonsModel.Lesson

    @Binding var currentQuestionIndex: Int
    let numQuestions: Int
    let currentQuestionNum: Int
    let correctAnswer: String
    let currentQuestionWord: String
    @Binding var answers: [String]
    @Binding var selectedAnswer: String?
    @Binding var showCorrectAnswer: Bool
    

    
    var body: some View {
        VStack(alignment: .leading) {
            // Question # and Question
            Text("Question \(currentQuestionNum) / \(lesson.vocabList.count)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.bottom, Constants.QuestionNumTextBottomPadding)
            Group {
                Text("What does ") +
                Text(currentQuestionWord)
                    .bold().foregroundStyle(.blue) +
                Text(" mean in English?")
            }
            .font(.title2).padding(.bottom, Constants.QuestionBottomPadding)
            
            // Answers
            ForEach(answers, id: \.self) { answer in
                Button {
                    if !showCorrectAnswer {
                        selectedAnswer = selectedAnswer != answer ? answer : nil
                    }
                } label: {
                    HStack {
                        if showCorrectAnswer && selectedAnswer == answer {
                            Image(systemName: selectedAnswer == correctAnswer ? "checkmark.circle.fill" : "x.circle.fill").foregroundStyle(selectedAnswer == correctAnswer ? .green : .red)
                        } else if showCorrectAnswer && correctAnswer == answer {
                            Image(systemName: "checkmark.circle").foregroundStyle(.green)
                        } else {
                            Image(systemName: selectedAnswer == answer ? "inset.filled.circle" : "circle.circle").foregroundStyle(.blue)
                        }
                        Text(answer).foregroundStyle(Color.black)
                        Spacer()
                    }
                    .padding(SharedConstants.standardPadding)
                    .background(.bar)
                    .cornerRadius(SharedConstants.cornerRadius)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
    }
    
    // MARK: - Constants
    private struct Constants {
        static let QuestionNumTextBottomPadding: Double = 5
        static let QuestionBottomPadding: Double = 25
    }
}
