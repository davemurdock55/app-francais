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
    private var lessonsModel = LessonsModel()
    
    init() {
        loadLessonProgress()
    }
    
    // MARK: - Model access
    // AI did help me with this a bit
    var lessons: [LessonsModel.Lesson] {
        return lessonsModel.lessons
    }
    
    // MARK: - User Intents
    func shuffleVocab(for lessonNum: Int) {
        if let index = getLessonIndex(num: lessonNum) {
            lessonsModel.lessons[index].vocabList.shuffle()
        }
    }
    
    func handleLearnCompleteTap(num: Int) {
        if let index = getLessonIndex(num: num) {
            lessonsModel.lessons[index].toggleIsLearnComplete()
            
            persistentProgress.updateProgress(
                for: "lesson\(num)",
                item: "isLearnCompleted",
                isComplete: lessonsModel.lessons[index].isLearnCompleted)
        }
    }
    
    func handleStudyCompleteTap(num: Int) {
        if let index = getLessonIndex(num: num) {
            lessonsModel.lessons[index].toggleIsStudyComplete()
            persistentProgress.updateProgress(
                for: "lesson\(num)",
                item: "isStudyCompleted",
                isComplete: lessonsModel.lessons[index].isStudyCompleted)
        }
    }
    
    func handleQuizCompleteTap(num: Int) {
        if let index = getLessonIndex(num: num) {
            lessonsModel.lessons[index].toggleIsQuizComplete()
            persistentProgress.updateProgress(
                for: "lesson\(num)",
                item: "isQuizCompleted",
                isComplete: lessonsModel.lessons[index].isQuizCompleted)
        }
    }
    
    
    // MARK: - Helpers
    private func getLessonIndex(num: Int) -> Int? {
        return lessonsModel.lessons.firstIndex(where: {$0.num == num})
    }
    
    private func loadLessonProgress() {
        for lesson in lessonsModel.lessons {
            let persistentLessonKey = "lesson\(lesson.num)"
            
            if let lessonIndex = getLessonIndex(num: lesson.num) {
                
                if let progress = persistentProgress.progress[persistentLessonKey] {
                    lessonsModel.lessons[lessonIndex].isLearnCompleted = progress["isLearnCompleted"] ?? false
                    lessonsModel.lessons[lessonIndex].isStudyCompleted = progress["isStudyCompleted"] ?? false
                    lessonsModel.lessons[lessonIndex].isQuizCompleted = progress["isQuizCompleted"] ?? false
                }
                
            }
        }
    }
    
}
