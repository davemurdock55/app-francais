//
//  PersistentScores.swift
//  AppFrancais
//
//  Created by David Murdock on 10/25/24.
//

import Foundation

typealias ScoresItem = [String: Int]
typealias LessonScoresItem = [String: ScoresItem]

struct PersistentScores {
    
    private static var lessonsModel = LessonsModel()

    // To set a default persistant state:
    private static func defaultScores() -> LessonScoresItem {
       var defaultScores: LessonScoresItem = [:]

       for lesson in lessonsModel.lessons {
           defaultScores["lesson\(lesson.num)"] = ["highScore": 0, "mostRecentScore": 0]
       }
       
       return defaultScores
    }
    
    private static func readScores() -> LessonScoresItem {
        UserDefaults.standard.dictionary(forKey: Key.scores) as? LessonScoresItem ?? defaultScores()
    }
    
    var scoreStorage = readScores() {
        didSet {
            UserDefaults.standard.set(scoreStorage, forKey: Key.scores)
        }
    }
    
    mutating func updateHighScore(for persistentScoresLessonKey: String, newHighScore newValue: Int) {
        // if the "lesson\(num)" key is not nil in the highScoreStorage dictionary...
        if var lessonScoresItem = scoreStorage[persistentScoresLessonKey] {
            // then update the highscore item in that highScoreStorage dictionary with the newValue...
            lessonScoresItem["highScore"] = newValue
            //  and save that updated dictionary back into the highScoreStorage dictionary
            scoreStorage[persistentScoresLessonKey] = lessonScoresItem
        } else {
            // if the lesson was nil ("lesson\(num)" was nil (possibly not created or not found), then make a new dictionary for that "lesson\(num)" key with the "highscore" item as the key and the newValue as the value
            scoreStorage[persistentScoresLessonKey] = ["highScore": newValue, "mostRecentScore": newValue]
        }
    }
    
    mutating func updateMostRecentScore(for persistentScoresLessonKey: String, newRecentScore newValue: Int) {
        if var lessonScoresItem = scoreStorage[persistentScoresLessonKey] {
            lessonScoresItem["mostRecentScore"] = newValue
            scoreStorage[persistentScoresLessonKey] = lessonScoresItem
        } else {
            scoreStorage[persistentScoresLessonKey] = ["highScore": newValue, "mostRecentScore": newValue]
        }
    }
    
    private struct Key {
        static let scores = "Scores"
    }
}
