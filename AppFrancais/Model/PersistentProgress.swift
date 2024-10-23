//
//  PersistentProgress.swift
//  AppFrancais
//
//  Created by David Murdock on 10/17/24.
//

import Foundation

typealias ItemProgress = [String: Bool]
typealias LessonProgress = [String: ItemProgress]

struct PersistentProgress {
    
    private static var lessonsModel = LessonsModel()

    // To set a default persistant state:
       private static func defaultProgress() -> LessonProgress {
           var defaultProgress: LessonProgress = [:]

           for lesson in lessonsModel.lessons {
               defaultProgress["lesson\(lesson.num)"] = ["isLearnCompleted": false, "isStudyCompleted": false, "isQuizCompleted": false]
           }
           
           return defaultProgress
       }
    
    private static func readProgress() -> LessonProgress {
        UserDefaults.standard.dictionary(forKey: Key.progress) as? LessonProgress ?? defaultProgress()
    }
    
    var progress = readProgress() {
        didSet {
            UserDefaults.standard.set(progress, forKey: Key.progress)
        }
    }
    
    mutating func updateProgress(for persistentLessonProgressKey: String, item progressItem: String, isComplete newValue: Bool) {
        // if the "lesson\(num)" key is not nil in the persistent progress dictionary...
        if var lessonProgress = progress[persistentLessonProgressKey] {
            // then update the chosen progress item in that lessonProgress dictionary with the newValue...
            lessonProgress[progressItem] = newValue
            //  and save that updated dictionary back into the persistent progress dictioanry
            progress[persistentLessonProgressKey] = lessonProgress
            
        } else {
            // if the lesson was nil ("lesson\(num)" was nil (possibly not created or not found), then make a new dictionary for that "lesson\(num)" key with the progress item as the key and the newValue as the value
            progress[persistentLessonProgressKey] = [progressItem: newValue]
        }
        
    }
    
    private struct Key {
        static let progress = "Progress"
    }
}
