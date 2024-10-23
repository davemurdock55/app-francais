//
//  PersistentProgress.swift
//  AppFrancais
//
//  Created by David Murdock on 10/17/24.
//

import Foundation

typealias ItemProgress = [String: Bool]
typealias LessonProgress = [String: ItemProgress]

let myProgress = [
    "topic1": ["read": true, "studied": true, "passed": true],
    "topic2": ["read": true, "studied": false, "passed": false],
]

struct PersistentProgress {

    
    private static func readProgress() -> LessonProgress {
        UserDefaults.standard.dictionary(forKey: Key.progress) as? LessonProgress ?? LessonProgress()
        // `?? LessonProgress()` is the same thing as doing `?? [String: [String: Bool]]`
    }
    
    var progress = readProgress() {
        didSet {
            UserDefaults.standard.set(progress, forKey: Key.progress)
        }
    }
    
    mutating func updateProgress(for lessonID: String, item: String, isCompleted: Bool) {
           if progress[lessonID] == nil {
               progress[lessonID] = [:]
           }
           progress[lessonID]?[item] = isCompleted
       }
    
    private struct Key {
        static let progress = "Progress"
    }
}
