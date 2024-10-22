//
//  ViewModel.swift
//  AppFrancais
//
//  Created by David Murdock on 10/10/24.
//

import Foundation

@Observable class LessonsViewModel: ObservableObject {
    
    // MARK: - Properties
    private var lessonsModel = LessonsModel()
    
    var currentLesson: LessonsModel.Lesson?
    
    // MARK: - Model access
    // AI did help me with this a bit
    var lessons: [LessonsModel.Lesson] {
        return lessonsModel.lessons
    }
    
    // MARK: - User Intents
    func handleLearnCompleteTap(num: Int) {
        guard var selectedLesson = getLesson(num: num) else {
            print("Lesson not found")
            return
        }
        print(selectedLesson.learn)
        selectedLesson.toggleIsLearnComplete()
    }
    
    
    // MARK: - Helpers
    private func getLesson(num: Int) -> LessonsModel.Lesson? {
        return lessons.first(where: {$0.num == num})
    }
    
    func setCurrentLesson(selectedLesson: LessonsModel.Lesson) -> Void {
        currentLesson = selectedLesson
        print("set the current lesson to: \(currentLesson?.num ?? -1)")
    }
    
}
