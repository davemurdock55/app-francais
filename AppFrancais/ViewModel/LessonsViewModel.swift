//
//  LessonsViewModel.swift
//  AppFrancais
//
//  Created by David Murdock on 10/10/24.
//

import Foundation

@Observable class LessonsViewModel: ObservableObject {
    
    // MARK: - Properties
    private var persistentProgress = PersistentProgress()
    private var persistentScores = PersistentScores()
    private var lessonsModel = LessonsModel()
    private var soundPlayer = SoundPlayer()
    
    init() {
        loadPersistentLessonProgress()
        loadPersistentScores()
    }
    
    // MARK: - Model access
    // AI did help me with this
    var lessons: [LessonsModel.Lesson] {
        return lessonsModel.lessons
    }
    
    // MARK: - User Intents
    
    // Shuffle the vocab flashcards for the Study section
    // learned from AI there is a difference between .shuffle() and .shuffled()
    func shuffleFlashcards(for vocabList: [(String, String)]) -> [(String, String)] {
        return vocabList.shuffled()
    }
    
    // Generate four answer options including the correct one for the Quiz
    // I did use AI for this out of convenience and time saving (I thought it was a cool way to use map and filter)
    func generateQuizAnswers(for lessonNum: Int, correctAnswer: String) -> [String] {
        if let lessonIndex = getLessonIndex(num: lessonNum) {
            var answers = lessonsModel.lessons[lessonIndex].vocabList.map { $0.1 }.filter { $0 != correctAnswer }
            answers.shuffle()
            answers = Array(answers.prefix(3))
            answers.append(correctAnswer)
            
            return answers.shuffled()
        }
        else {
            return []
        }
    }
    
    func updateHighScore(for num: Int, withNewScore newHighscore: Int) {
        if let index = getLessonIndex(num: num) {
            lessonsModel.lessons[index].highScore = newHighscore
            persistentScores.updateHighScore(for: "lesson\(num)", newHighScore: newHighscore)
        }
    }
    
    func updateMostRecentScore(for num: Int, withNewScore newRecentScore: Int) {
        if let index = getLessonIndex(num: num) {
            lessonsModel.lessons[index].mostRecentScore = newRecentScore
            persistentScores.updateMostRecentScore(for: "lesson\(num)", newRecentScore: newRecentScore)
        }
    }
    
    func handleLearnCompleteTap(for num: Int) {
        if let index = getLessonIndex(num: num) {
            if !lessonsModel.lessons[index].isLearnCompleted {
                playCorrectAnswerSound()
            }
            
            lessonsModel.lessons[index].toggleIsLearnComplete()
            persistentProgress.updateProgress(
                for: "lesson\(num)",
                item: "isLearnCompleted",
                isComplete: lessonsModel.lessons[index].isLearnCompleted)
        }
    }
    
    func handleStudyCompleteTap(for num: Int) {
        if let index = getLessonIndex(num: num) {
            if !lessonsModel.lessons[index].isStudyCompleted {
                playCorrectAnswerSound()
            }
            
            lessonsModel.lessons[index].toggleIsStudyComplete()
            persistentProgress.updateProgress(
                for: "lesson\(num)",
                item: "isStudyCompleted",
                isComplete: lessonsModel.lessons[index].isStudyCompleted)
        }
    }
    
    func handleQuizCompleteTap(for num: Int) {
        if let index = getLessonIndex(num: num) {
            if !lessonsModel.lessons[index].isQuizCompleted {
                playCorrectAnswerSound()
            }
            
            lessonsModel.lessons[index].toggleIsQuizComplete()
            persistentProgress.updateProgress(
                for: "lesson\(num)",
                item: "isQuizCompleted",
                isComplete: lessonsModel.lessons[index].isQuizCompleted)
        }
    }
    
    // MARK: - Sound Intents
    
    func playCorrectAnswerSound() {
        Task {
            await soundPlayer.playSound(named: "Correct_answer.mp3")
        }
    }
    
    func playBadAnswerSound() {
        Task {
            await soundPlayer.playSound(named: "Bad_answer.mp3")
        }
    }
    
    func playLevelCompleteSound() {
        Task {
            await soundPlayer.playSound(named: "Level_complete.mp3")
        }
    }
    
    // MARK: - Helpers
    private func getLessonIndex(num: Int) -> Int? {
        return lessonsModel.lessons.firstIndex(where: {$0.num == num})
    }
    
    private func loadPersistentLessonProgress() {
        for lesson in lessonsModel.lessons {
            let persistentLessonKey = "lesson\(lesson.num)"
            
            if let lessonIndex = getLessonIndex(num: lesson.num) {
                
                if let progress = persistentProgress.progress[persistentLessonKey] {
                    // AI helped me build out the basics for these a bit
                    lessonsModel.lessons[lessonIndex].isLearnCompleted = progress["isLearnCompleted"] ?? false
                    lessonsModel.lessons[lessonIndex].isStudyCompleted = progress["isStudyCompleted"] ?? false
                    lessonsModel.lessons[lessonIndex].isQuizCompleted = progress["isQuizCompleted"] ?? false
                }
                
            }
        }
    }
    
    private func loadPersistentScores() {
        for lesson in lessonsModel.lessons {
            let persistentScoresLessonKey = "lesson\(lesson.num)"
            
            if let lessonIndex = getLessonIndex(num: lesson.num) {
                
                if let scores = persistentScores.scoreStorage[persistentScoresLessonKey] {
                    lessonsModel.lessons[lessonIndex].highScore = scores["highScore"] ?? 0
                    lessonsModel.lessons[lessonIndex].mostRecentScore = scores["mostRecentScore"] ?? 0
                }
                
            }
        }
    }
    
}
