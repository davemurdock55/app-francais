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
    
    @State private var isTakingQuiz: Bool = false
    
    @State private var score: Int = 0
    
    @State private var currentQuestionIndex = 0
    @State private var correctAnswer: String
    @State private var answers: [String] = []
    @State private var selectedAnswer: String? = nil
    
    @State private var showAnswer = false
    
    @State private var timeRemaining: Double = 10.0
    @State private var timer: Timer? = nil
    
    @State private var celebrate: Bool = false
    
    init(lesson: LessonsModel.Lesson) {
        self.lesson = lesson
        correctAnswer = lesson.vocabList[0].1
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "questionmark.circle")
                    .foregroundColor(!lesson.isQuizCompleted ? .red : .green)
                Text("Quiz")
            }.font(.title)
            
            ScrollView {
                if !lesson.isQuizCompleted {
                    // Score
                    Text("Score: \(score)").font(.title2).fontWeight(.medium)
                    
                    // Timer Circle
                    QuizTimerView(timeRemaining: $timeRemaining)
                        .onAppear {
                            startTimer()
                        }
                        .onDisappear {
                            stopTimer()
                        }
                    
                    
                    // Question Area
                    
//                    QuestionsView()
                    VStack(alignment: .leading) {
                        // Question # and Question
                        Text("Question \(currentQuestionIndex + 1) / \(lesson.vocabList.count)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .padding(.bottom, 5)
                        Group {
                            Text("What does ") +
                            Text(lesson.vocabList[currentQuestionIndex].0)
                                .bold().foregroundStyle(.blue) +
                            Text(" mean in English?")
                        }
                        .font(.title2).padding(.bottom, 25)
                        
                        // Answers
                        ForEach(answers, id: \.self) { answer in
                            Button {
                                if !showAnswer {
                                    selectedAnswer = selectedAnswer != answer ? answer : nil
                                }
                            } label: {
                                HStack {
                                    if showAnswer && selectedAnswer == answer {
                                        Image(systemName: selectedAnswer == correctAnswer ? "checkmark.circle.fill" : "x.circle.fill").foregroundStyle(selectedAnswer == correctAnswer ? .green : .red)
                                    } else if showAnswer && correctAnswer == answer {
                                        Image(systemName: "checkmark.circle").foregroundStyle(.green)
                                    } else {
                                        Image(systemName: selectedAnswer == answer ? "inset.filled.circle" : "circle.circle").foregroundStyle(.blue)
                                    }
                                    Text(answer).foregroundStyle(Color.black)
                                    Spacer()
                                }
                                .padding(15)
                                .background(.bar)
                                .cornerRadius(10)
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    // Check Answer / Next Buttons
                    Group {
                        if showAnswer {
                            Button {
                                goToNextQuestion()
                            } label: {
                                HStack {
                                    Text("Next")
                                    Image(systemName: "arrow.forward")
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .padding()
                            .background(selectedAnswer == correctAnswer ? .green : .red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity)
                        } else {
                            Button {
                                if let selectedAnswer {
                                    checkAnswer(selected: selectedAnswer, correct: lesson.vocabList[currentQuestionIndex].1)
                                }
                            } label: {
                                Label("Check Answer", systemImage: "checkmark.circle.badge.questionmark")
                                    .frame(maxWidth: .infinity)
//                                Text("Check Answer")
                            }
                            .padding()
                            .background((selectedAnswer != nil) ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .opacity(selectedAnswer != nil ? 1.0 : 0.5)
                            .disabled(selectedAnswer == nil)
                            .frame(maxWidth: .infinity)
                        }
                    }.padding(.horizontal)
                } else {
                    // Quiz Finished Screen
                    Text("You finished the quiz for Lesson \(lesson.num): \(lesson.name)!")
                        .padding()
                    
                    Text("Your Score: \(lesson.mostRecentScore)").font(.title).fontWeight(.semibold)
                    Text("Your High Score: \(lesson.highScore)").font(.title3)
                    
                    Button {
                        withAnimation {
                            resetQuiz()
                        }
                    } label: {
                        Label("Restart Quiz", systemImage: "arrow.counterclockwise")
                            
                    }
                    .padding(15)
                    .background(.blue)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    CompleteButtonView(
                        activity: "Quiz",
                        isCompleted: lesson.isQuizCompleted,
                        handlePress: { lessonViewModel.handleQuizCompleteTap(for: lesson.num) }
                    )
                }
                
            }
        }
        .displayConfetti(isActive: $celebrate)
        .onAppear {
            resetQuiz()
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            withAnimation(.linear) {
                if timeRemaining >= 0.01 {
                    timeRemaining -= 0.01
                } else {
                    stopTimer()
                }
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
               timer = nil
    }
    
    private func checkAnswer(selected: String, correct: String) {
        let bonusPointsTime = timeRemaining
        let bonusPoints = bonusPointsTime > 0.0001 ? Int(ceil(bonusPointsTime)) : 0
        stopTimer()
        
        if selected == correct {
            score += 10 + bonusPoints
            lessonViewModel.playCorrectAnswerSound()
            celebrate = true
            
            // Timeout to turn confetti off after 1 second
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    celebrate = false
                }
            }
        } else if selected != correct {
            lessonViewModel.playBadAnswerSound()
        }
        showAnswer = true
    }
    
    private func goToNextQuestion() {
        if (currentQuestionIndex + 1) < lesson.vocabList.count {
            celebrate = false
            currentQuestionIndex += 1
            correctAnswer = lesson.vocabList[currentQuestionIndex].1
            answers = lessonViewModel.generateQuizAnswers(for: lesson.num, correctAnswer: correctAnswer)
            selectedAnswer = nil
            showAnswer = false
            timeRemaining = 10.0
            startTimer()
        }
        // Finished Quiz
        else {
            lessonViewModel.updateMostRecentScore(for: lesson.num, withNewScore: score)
            if score > lesson.highScore {
                lessonViewModel.updateHighScore(for: lesson.num, withNewScore: score)
            }
            celebrate = true
            lessonViewModel.handleQuizCompleteTap(for: lesson.num)
            lessonViewModel.playLevelCompleteSound()
            currentQuestionIndex = 0
        }
    }
    
    private func resetQuiz() {
        score = 0
        
        currentQuestionIndex = 0
        correctAnswer = lesson.vocabList[0].1
        answers = []
        selectedAnswer = nil
        
        showAnswer = false
        
        answers = lessonViewModel.generateQuizAnswers(for: lesson.num, correctAnswer: lesson.vocabList[0].1)
        
        timeRemaining = 10.0
        timer = nil
        
        celebrate = false
    }
}
