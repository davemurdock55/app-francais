//
//  StudyView.swift
//  AppFrancais
//
//  Created by David Murdock on 10/18/24.
//

import SwiftUI

struct StudyView: View {
    @EnvironmentObject var lessonViewModel: LessonsViewModel
    var lesson: LessonsModel.Lesson
    
    @State private var flashcards: [(String, String)] = []
    @State private var currentIndex = 0
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    init(lesson: LessonsModel.Lesson) {
        self.lesson = lesson
        // changing the color of the TabView indices (found on StackOverflow)
        UIPageControl.appearance().currentPageIndicatorTintColor = .gray
        UIPageControl.appearance().pageIndicatorTintColor = .lightGray
    }
    
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Image(systemName: "rectangle.on.rectangle.circle")
                        .foregroundColor(!lesson.isStudyCompleted ? .gray : .green)
                    Text("Study")
                }.font(.title)
                
                
                VStack {
                    GeometryReader { geometry in
                        VStack {
                            TabView(selection: $currentIndex) {
                                // learned .indices from ChatGPT before you mentioned it in the midterm review
                                ForEach(flashcards.indices, id: \.self) { index in
                                    FlashcardView(vocab: flashcards[index])
                                        .tag(index)
                                        .padding()
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                            .background(.bar)
                            .cornerRadius(SharedConstants.cornerRadius)
                            // this shrinks the gray area (keeping in case I want it later)
                            // .frame(height: geometry.size.height - 50)
                        }
                        .frame(height: geometry.size.height)
                    }
                    .frame(height: Constants.flashcardsContainerWidth)
                }.padding(.horizontal)
                
                HStack {
                    Button {
                        // initially used AI to come up with efficient ways to go back and forth through indices
                        if currentIndex > 0 {
                            withAnimation {
                                currentIndex -= 1
                            }
                        }
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward.circle")
                            Text("Previous")
                        }
                        .padding()
                        .frame(width: Constants.CardNavButtonWidth)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(SharedConstants.cornerRadius)
                    }
                    
                    
                    Spacer()
                    
                    Button {
                        // initially used AI to come up with efficient ways to go back and forth through indices
                        if currentIndex < lesson.vocabList.count - 1 {
                            withAnimation {
                                currentIndex += 1
                            }
                        }
                    } label: {
                        HStack {
                            Text("Next")
                            Image(systemName: "chevron.forward.circle")
                        }
                        .padding()
                        .frame(width: Constants.CardNavButtonWidth)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(SharedConstants.cornerRadius)
                    }
                    
                }.padding()
                
                
                Spacer()
            }
            .onAppear {
                flashcards = lessonViewModel.shuffleFlashcards(for: lesson.vocabList)
            }
            
            CompleteButtonView(
                activity: "Study",
                isCompleted: lesson.isStudyCompleted,
                handlePress: { lessonViewModel.handleStudyCompleteTap(for: lesson.num) }
            )
        }
    }

    // MARK: - Constants
    private struct Constants {
        static let CardNavButtonWidth: Double = 150
        static let flashcardsContainerWidth: Double = 400
    }
    
}
