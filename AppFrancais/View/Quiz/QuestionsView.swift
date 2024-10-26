////
////  QuestionsView.swift
////  AppFrancais
////
////  Created by David Murdock on 10/25/24.
////
//
//import SwiftUI
//
//struct QuestionsView: View {
//    @EnvironmentObject var lessonViewModel: LessonsViewModel
//    var lesson: LessonsModel.Lesson
//    
//    @Binding var currentQuestionIndex: Int
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            // Question # and Question
//            Text("Question \(currentQuestionIndex + 1) / \(lesson.vocabList.count)")
//                .font(.subheadline)
//                .foregroundStyle(.secondary)
//                .padding(.bottom, 5)
//            Group {
//                Text("What does ") +
//                Text(lesson.vocabList[currentQuestionIndex].0)
//                    .bold().foregroundStyle(.blue) +
//                Text(" mean in English?")
//            }
//            .font(.title2).padding(.bottom, 25)
//            
//            // Answers
//            ForEach(answers, id: \.self) { answer in
//                Button {
//                    if !showAnswer {
//                        selectedAnswer = selectedAnswer != answer ? answer : nil
//                    }
//                } label: {
//                    HStack {
//                        if showAnswer && selectedAnswer == answer {
//                            Image(systemName: selectedAnswer == correctAnswer ? "checkmark.circle.fill" : "x.circle.fill").foregroundStyle(selectedAnswer == correctAnswer ? .green : .red)
//                        } else if showAnswer && correctAnswer == answer {
//                            Image(systemName: "checkmark.circle").foregroundStyle(.green)
//                        } else {
//                            Image(systemName: selectedAnswer == answer ? "inset.filled.circle" : "circle.circle").foregroundStyle(.blue)
//                        }
//                        Text(answer).foregroundStyle(Color.black)
//                        Spacer()
//                    }
//                    .padding(15)
//                    .background(.bar)
//                    .cornerRadius(10)
//                }
//                .frame(maxWidth: .infinity)
//            }
//        }
//        .padding()
//    }
//}
