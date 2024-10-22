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
    // most of what's here probably won't work with my code, but you may need to do something like this

//    private static func defaultProgress() -> LessonProgress {
//        var defaultProgress: LessonProgress = [:]
//        
//        for lesson in lessonsModel.lessons {
//            defaultProgress[lesson] = [:]
//        }
//    }
    
    private static func readProgress() -> LessonProgress {
        UserDefaults.standard.dictionary(forKey: Key.progress) as? LessonProgress ?? LessonProgress()
        // `?? LessonProgress()` is the same thing as doing `?? [String: [String: Bool]]`
    }
    
    var progress = readProgress() {
        didSet {
            UserDefaults.standard.set(progress, forKey: Key.progress)
        }
    }

// could do something like this if you wanted to store each lesson separately in the user defaults
//    private enum ItemKey: String {
//        case lesson // read
//        case practice // study
//        case quiz // quiz
//    }
    
    private struct Key {
        static let progress = "Progress"
    }
}
