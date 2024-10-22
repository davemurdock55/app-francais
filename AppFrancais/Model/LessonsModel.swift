//
//  LessonsModel.swift
//  AppFrancais
//
//  Created by David Murdock on 10/10/24.
//

//import Foundation

var testLessonText1 = "Lesson 1 text"
var testLessonText2 = "Lesson 2 text"
var testLessonText3 = "Lesson 3 text"
var testLessonText4 = "Lesson 4 text"
var testLessonText5 = "Lesson 5 text"
var testLessonText6 = "Lesson 6 text"

struct LessonsModel {
    // MARK: - Constants
    
    // MARK: - Nested Structs
    struct Lesson: Identifiable {
        var id: Int { num }
        let num: Int
        let name: String
        var isLessonCompleted: Bool = false
        var learn: Learn
        
        init(num: Int, name: String, learn: Learn) {
            self.num = num
            self.name = name
            self.learn = learn
        }
        
        mutating func toggleIsLessonComplete() {
            self.isLessonCompleted.toggle()
        }

        mutating func toggleIsLearnComplete() {
            print("made it here!")
            self.learn.isLearnCompleted.toggle()
            print("learn \(self.learn)")
        }
        
        mutating func toggleIsStudyComplete(lesson: Lesson) {
            
        }
        
        mutating func toggleIsQuizComplete(lesson: Lesson) {
            
        }
    }
    
    struct Learn {
        var isLearnCompleted: Bool = false
        let lessonText: String
    }
    
    struct Study {
        var isStudyCompleted: Bool = false
        let flashcards: [[String:String]]
    }
    
    struct Quiz {
        var isQuizCompleted: Bool = false
    }
    
    enum QuestionType {
        case treuFalse
        case multipleChoice
        case fillInTheBlank
    }
    
    struct Question {
        var questionText: String
        var correctAnswerIndex: Int
        var questionType: QuestionType
        var answers: [String]? // nillable because it could be a different kind of quiz
    }

    
    // MARK: - Properties
    var lessons: [Lesson]
    
    
    // MARK: - Initialization
    init() {
        lessons = [
            Lesson(
                num: 1,
                name: "Basic Greetings and Farewells",
                learn: Learn(isLearnCompleted: false, lessonText: testLessonText1)),
            Lesson(
                num: 2,
                name: "Common Phrases",
                learn: Learn(isLearnCompleted: false, lessonText: testLessonText2)),
            Lesson(
                num: 3,
                name: "Numbers",
                learn: Learn(isLearnCompleted: false, lessonText: testLessonText3)),
            Lesson(
                num: 4,
                name: "Colors",
                learn: Learn(isLearnCompleted: false, lessonText: testLessonText4)),
            Lesson(
                num: 5,
                name: "Food and Drink",
                learn: Learn(isLearnCompleted: false, lessonText: testLessonText5)),
            Lesson(
                num: 6,
                name: "Days of the Week",
                learn: Learn(isLearnCompleted: false, lessonText: testLessonText6)),
        ]
    }
    
    // MARK: - Helpers
    
    
    // MARK: - Private Helpers

}
