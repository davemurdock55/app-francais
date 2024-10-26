//
//  QuizView.swift
//  AppFrancais
//
//  Created by David Murdock on 10/18/24.
//

import SwiftUI

struct QuizView: View {
    
    // MARK: - Imported Variables
    @EnvironmentObject var lessonViewModel: LessonsViewModel
    var lesson: LessonsModel.Lesson
    
    // MARK: - State Variables
    @State private var isTakingQuiz: Bool = false
    
    @State private var score: Int = 0
    
    @State private var currentQuestionIndex = 0
    @State private var answers: [String] = []
    @State private var selectedAnswer: String? = nil
    @State private var showCorrectAnswer = false
    @State private var anyIncorrectAnswers: Bool = false
    
    @State private var timeRemaining: Double = Constants.initialBonusTime
    @State private var timer: Timer? = nil
    
    @State private var celebrate: Bool = false
    
    // MARK: - Computed Variables
    private var numQuestions: Int {
        lesson.vocabList.count
    }
    
    private var currentQuestionNum: Int {
        currentQuestionIndex + 1
    }
    
    private var currentQuestionWord: String {
        lesson.vocabList[currentQuestionIndex].0
    }
    
    private var correctAnswer: String {
        lesson.vocabList[currentQuestionIndex].1
    }

    // MARK: - View
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "questionmark.circle")
                    .foregroundColor(!lesson.isQuizCompleted ? .red : .green)
                Text("Quiz")
            }.font(.title)
            
            ScrollView {
                
                if isTakingQuiz {
                    // Score
                    Text("Score: \(score)").font(.title2).fontWeight(.medium)
                    
                    // Timer Circle
                    QuizTimer(timeRemaining: $timeRemaining)
                        .onAppear {
                            startTimer()
                        }
                        .onDisappear {
                            stopTimer()
                        }
                    
                    
                    // Question Area
                    QuestionsView(lesson: lesson,
                          currentQuestionIndex: $currentQuestionIndex,
                          numQuestions: numQuestions,
                          currentQuestionNum: currentQuestionNum,
                          correctAnswer: correctAnswer,
                          currentQuestionWord: currentQuestionWord,
                          answers: $answers,
                          selectedAnswer: $selectedAnswer,
                          showCorrectAnswer: $showCorrectAnswer
                    )
                    
                    Spacer()
                    
                    // Check Answer / Next Buttons
                    Group {
                        if showCorrectAnswer {
                            NextQuestionButton(goToNextQuestion: goToNextQuestion, selectedAnswer: $selectedAnswer, correctAnswer: correctAnswer)
                        } else {
                            CheckAnswerButton(checkAnswer: checkAnswer, selectedAnswer: $selectedAnswer, correctAnswer: correctAnswer)
                        }
                    }.padding(.horizontal)
                } else if (currentQuestionNum) >= numQuestions {
                    // Quiz EndScreen
                    QuizScoreView(lesson: lesson, anyIncorrectAnswers: $anyIncorrectAnswers, resetQuiz: resetQuiz)
                }
                
            }
        }
        .displayConfetti(isActive: $celebrate)
        .onAppear {
            resetQuiz()
        }
    }

    // MARK: - Quiz Helper Functions
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
            anyIncorrectAnswers = true
            lessonViewModel.playBadAnswerSound()
        }
        showCorrectAnswer = true
    }
    
    private func goToNextQuestion() {
        if (currentQuestionNum) < numQuestions {
            celebrate = false
            currentQuestionIndex += 1
            answers = lessonViewModel.generateQuizAnswers(for: lesson.num, correctAnswer: correctAnswer)
            selectedAnswer = nil
            showCorrectAnswer = false
            timeRemaining = Constants.initialBonusTime
            startTimer()
        }
        // Finished Quiz
        else {
            lessonViewModel.updateMostRecentScore(for: lesson.num, withNewScore: score)
            if score > lesson.highScore {
                lessonViewModel.updateHighScore(for: lesson.num, withNewScore: score)
            }
            
            if !anyIncorrectAnswers {
                if lesson.isQuizCompleted == false {
                    lessonViewModel.handleQuizCompleteTap(for: lesson.num)
                }
                celebrate = true
                lessonViewModel.playLevelCompleteSound()
            } else {
                celebrate = false
            }
            
            isTakingQuiz = false
        }
    }
    
    private func resetQuiz() {
        score = 0
        
        currentQuestionIndex = 0
        answers = []
        selectedAnswer = nil
        showCorrectAnswer = false
        anyIncorrectAnswers = false
        
        timeRemaining = Constants.initialBonusTime
        timer = nil
        
        celebrate = false
        
        // go get new randomized answers for the first question (based on correctAnswer)
        answers = lessonViewModel.generateQuizAnswers(for: lesson.num, correctAnswer: correctAnswer)
        
        isTakingQuiz = true
    }
    
    private struct Constants {
        static let initialBonusTime = 10.0
    }
}
