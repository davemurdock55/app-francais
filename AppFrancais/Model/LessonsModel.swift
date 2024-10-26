//
//  LessonsModel.swift
//  AppFrancais
//
//  Created by David Murdock on 10/10/24.
//

import Foundation

typealias VocabListType = [(String, String)]

struct LessonsModel {
    
    // MARK: - Nested Structs
    struct Lesson: Identifiable {
        var id: Int { num }
        let num: Int
        let name: String
        let lessonText: String
        var vocabList: VocabListType
        var highScore: Int = 0
        var mostRecentScore: Int = 0
        var isLessonCompleted: Bool = false
        var isLearnCompleted: Bool = false
        var isStudyCompleted: Bool = false
        var isQuizCompleted: Bool = false
        
        init(num: Int, name: String, lessonText: String, vocabList: VocabListType) {
            self.num = num
            self.name = name
            self.lessonText = lessonText
            self.vocabList = vocabList
        }
        
        mutating func toggleIsLessonComplete() {
            self.isLessonCompleted.toggle()
        }

        mutating func toggleIsLearnComplete() {
            self.isLearnCompleted.toggle()
        }
        
        mutating func toggleIsStudyComplete() {
            self.isStudyCompleted.toggle()
        }
        
        mutating func toggleIsQuizComplete() {
            self.isQuizCompleted.toggle()
        }
        
        mutating func updateHighScore(score: Int) {
            self.highScore = score
        }
        
        mutating func updateMostRecentScore(score: Int) {
            self.mostRecentScore = score
        }
    }
    
    // MARK: - Properties
    var lessons: [Lesson]
    
    
    // MARK: - Initialization
    init() {
        lessons = [
            Lesson(
                num: 1,
                name: "Basic Greetings and Farewells",
                lessonText: lesson1Text,
                vocabList: lesson1Vocab
            ),
            Lesson(
                num: 2,
                name: "Common Phrases",
                lessonText: lesson2Text,
                vocabList: lesson2Vocab
            ),
            Lesson(
                num: 3,
                name: "Numbers",
                lessonText: lesson3Text,
                vocabList: lesson3Vocab
            ),
            Lesson(
                num: 4,
                name: "Colors",
                lessonText: lesson4Text,
                vocabList: lesson4Vocab
            ),
            Lesson(
                num: 5,
                name: "Family Members",
                lessonText: lesson5Text,
                vocabList: lesson5Vocab
            ),
            Lesson(
                num: 6,
                name: "Food and Drink",
                lessonText: lesson6Text,
                vocabList: lesson6Vocab
            ),
            Lesson(
                num: 7,
                name: "Common Adjectives",
                lessonText: lesson7Text,
                vocabList: lesson7Vocab
            ),
            Lesson(
                num: 8,
                name: "Days of the Week",
                lessonText: lesson8Text,
                vocabList: lesson8Vocab
            ),
            Lesson(
                num: 9,
                name: "The Weather",
                lessonText: lesson9Text,
                vocabList: lesson9Vocab
            ),
            Lesson(
                num: 10,
                name: "Common Verbs",
                lessonText: lesson10Text,
                vocabList: lesson10Vocab
            ),
        ]
    }
    
    // MARK: - Helpers
    
    
    // MARK: - Private Helpers

    
    // MARK: - Lesson Information
    
    var lesson1Text = """
    This lesson introduces key phrases for starting and ending conversations in French. You'll learn common greetings, farewells, and how to ask and respond to "How are you?".
    """

    var lesson1Vocab = [
        ("Bonjour", "\"Hello\" or \"Good morning\""),
        ("Au revoir", "Goodbye"),
        ("Bonne journée", "Have a good day"),
        ("Bonne après-midi", "Good afternoon"),
        ("Bonsoir", "Good evening"),
        ("Bonne nuit", "Good night"),
        ("Comment ça va?", "How are you?"),
        ("Ça va bien", "I’m doing well"),
        ("À bientôt", "See you soon")
    ]


    var lesson2Text = """
    This lesson covers useful French phrases for everyday interactions. You'll learn how to ask politely, express gratitude, and make basic requests or inquiries.
    """
    
    var lesson2Vocab = [
        ("S’il vous plaît", "Please"),
        ("Merci", "Thank you"),
        ("De rien", "You’re welcome"),
        ("Je suis désolé", "I’m sorry"),
        ("Combien ça coûte?", "How much does it cost?"),
        ("Où est…?", "Where is...?"),
        ("Je voudrais", "I would like")
    ]

    
    var lesson3Text = """
    Numbers are essential for any language learner. In this lesson, you’ll be introduced to the French words for numbers 1 through 10, which are key for counting and basic math.
    """
    
    var lesson3Vocab = [
        ("Un", "1"),
        ("Deux", "2"),
        ("Trois", "3"),
        ("Quatre", "4"),
        ("Cinq", "5"),
        ("Six", "6"),
        ("Sept", "7"),
        ("Huit", "8"),
        ("Neuf", "9"),
        ("Dix", "10")
    ]

    var lesson4Text = """
    This lesson introduces the basic French color vocabulary. Being able to describe colors is helpful in daily conversations, from discussing clothing to describing objects.
    """
    
    var lesson4Vocab = [
        ("Rouge", "Red"),
        ("Bleu", "Blue"),
        ("Vert", "Green"),
        ("Jaune", "Yellow"),
        ("Noir", "Black"),
        ("Blanc", "White"),
        ("Orange", "Orange"),
        ("Rose", "Pink")
    ]

    
    var lesson5Text = """
    This lesson focuses on family-related vocabulary. Whether you're discussing your own family or asking about someone else’s, these terms will help you talk about loved ones.
    """
    
    var lesson5Vocab = [
        ("Mère", "Mother"),
        ("Père", "Father"),
        ("Frère", "Brother"),
        ("Sœur", "Sister"),
        ("Grand-père", "Grandfather"),
        ("Grand-mère", "Grandmother"),
        ("Oncle", "Uncle"),
        ("Tante", "Aunt")
    ]
    

    var lesson6Text = """
    Learning how to talk about food and drink is essential for dining out or grocery shopping in French-speaking regions. This lesson introduces common terms you’ll encounter.
    """
    
    var lesson6Vocab = [
        ("Eau", "Water"),
        ("Nourriture", "Food"),
        ("Pain", "Bread"),
        ("Fruit", "Fruit"),
        ("Viande", "Meat"),
        ("Légume", "Vegetable"),
        ("Café", "Coffee"),
        ("Thé", "Tea")
    ]
    

    var lesson7Text = """
    Adjectives help you describe people, objects, and situations. This lesson covers some of the most common French adjectives, helping you to describe size, beauty, and emotions.
    """
    
    var lesson7Vocab = [
        ("Grand", "Big"),
        ("Petit", "Small"),
        ("Belle", "Beautiful"),
        ("Laid", "Ugly"),
        ("Heureux", "Happy"),
        ("Triste", "Sad"),
        ("Intéressant", "Interesting"),
        ("Ennuyeux", "Boring")
    ]
    

    var lesson8Text = """
    This lesson introduces the French names for the days of the week. Whether planning events or simply discussing your schedule, knowing these terms is essential.
    """
    
    var lesson8Vocab = [
        ("Lundi", "Monday"),
        ("Mardi", "Tuesday"),
        ("Mercredi", "Wednesday"),
        ("Jeudi", "Thursday"),
        ("Vendredi", "Friday"),
        ("Samedi", "Saturday"),
        ("Dimanche", "Sunday")
    ]
    

    var lesson9Text = """
    Talking about the weather is a common topic in conversation. This lesson provides essential weather-related phrases to help you describe different conditions.
    """
    
    var lesson9Vocab = [
        ("Il fait beau", "It’s sunny"),
        ("Il fait froid", "It’s cold"),
        ("C’est nuageux", "It’s cloudy"),
        ("Il pleut", "It’s raining"),
        ("Il neige", "It’s snowing"),
        ("Il fait chaud", "It’s hot")
    ]
    

    var lesson10Text = """
    Verbs are the backbone of any language. In this lesson, you’ll learn some of the most frequently used French verbs, which will allow you to express actions in conversation.
    """
    
    var lesson10Vocab = [
        ("Être", "To be"),
        ("Avoir", "To have"),
        ("Faire", "To do/make"),
        ("Aller", "To go"),
        ("Manger", "To eat"),
        ("Boire", "To drink"),
        ("Parler", "To speak"),
        ("Dire", "To say")
    ]

}
