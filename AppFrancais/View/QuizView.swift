//
//  QuizView.swift
//  AppFrancais
//
//  Created by David Murdock on 10/18/24.
//

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var lessonViewModel: LessonsViewModel
    var lesson: LessonsModel.Lesson
    
    @State private var score: Int = 0
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String? = nil
    @State private var showResult = false
    
    var body: some View {
        VStack {
//            Text("\(lesson.name)").font(.largeTitle)
            HStack {
                Image(systemName: "questionmark.circle")
                    .foregroundColor(!lesson.isQuizCompleted ? .red : .green)
                Text("Quiz")
            }.font(.title)
            
            Text("Score: \(score)")
            
            Form {
                if currentQuestionIndex < lesson.vocabList.count {
                    let question = lesson.vocabList[currentQuestionIndex]
                    let correctAnswer = question.1
                    let allAnswers = generateAnswers(correctAnswer: correctAnswer)
                    
                    Section(header: Text("Question \(currentQuestionIndex + 1)")) {
                        Text("What does \(question.0) mean in French?")
                        ForEach(allAnswers, id: \.self) { answer in
                            Button(action: {
                                selectedAnswer = answer
                                checkAnswer(selected: answer, correct: correctAnswer)
                            }) {
                                HStack {
                                    Text(answer)
                                    if selectedAnswer == answer {
                                        Spacer()
                                        Image(systemName: answer == correctAnswer ? "checkmark.circle" : "xmark.circle")
                                            .foregroundColor(answer == correctAnswer ? .green : .red)
                                    }
                                }
                            }
                        }
                    }
                    
                    if showResult {
                        Button("Next Question") {
                            currentQuestionIndex += 1
                            selectedAnswer = nil
                            showResult = false
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                } else {
                    Text("Quiz Completed! Your final score is \(score).")
                    CompleteButtonView(
                        activity: "Quiz",
                        isCompleted: lesson.isQuizCompleted,
                        handlePress: { lessonViewModel.handleQuizCompleteTap(num: lesson.num) }
                    )
                }
            }
            
            Spacer()
            

        }
    }
    
    // Generate four answer options including the correct one
    private func generateAnswers(correctAnswer: String) -> [String] {
        var answers = lesson.vocabList.map { $0.1 }.filter { $0 != correctAnswer }
        answers.shuffle()
        answers = Array(answers.prefix(3))
        answers.append(correctAnswer)
        return answers.shuffled()
    }
    
    // Check if the selected answer is correct and update the score
    private func checkAnswer(selected: String, correct: String) {
        if selected == correct {
            score += 1
        }
        showResult = true
    }
}
