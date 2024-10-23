//
//  LessonsViewModel.swift
//  AppFrancais
//
//  Created by David Murdock on 10/10/24.
//

import Foundation

@Observable class LessonsViewModel: ObservableObject {
    
    // MARK: - Properties
    private var lessonsModel = LessonsModel()
    
//    var currentLesson: LessonsModel.Lesson?
    
    // MARK: - Model access
    // AI did help me with this a bit
    var lessons: [LessonsModel.Lesson] {
        return lessonsModel.lessons
    }
    
    // MARK: - User Intents
    func handleLearnCompleteTap(num: Int) {
        guard let index = getLessonIndex(num: num) else {
            print("Lesson not found")
            return
        }
        
        lessonsModel.lessons[index].toggleIsLearnComplete()
//        objectWillChange.send()
    }
    
    func handleStudyCompleteTap(num: Int) {
        guard let index = getLessonIndex(num: num) else {
            print("Lesson not found")
            return
        }
        
        lessonsModel.lessons[index].toggleIsStudyComplete()
        objectWillChange.send()
    }
    
    func handleQuizCompleteTap(num: Int) {
        guard let index = getLessonIndex(num: num) else {
            print("Lesson not found")
            return
        }
        
        lessonsModel.lessons[index].toggleIsQuizComplete()
        objectWillChange.send()
    }
    
    
    // MARK: - Helpers
    private func getLessonIndex(num: Int) -> Int? {
        return lessonsModel.lessons.firstIndex(where: {$0.num == num})
    }
    
    
//    func setCurrentLesson(selectedLesson: LessonsModel.Lesson) -> Void {
//        currentLesson = selectedLesson
//        print("set the current lesson to: \(currentLesson?.num ?? -1)")
//    }
    
}
