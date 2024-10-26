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
        UIPageControl.appearance().currentPageIndicatorTintColor = .gray
        UIPageControl.appearance().pageIndicatorTintColor = .lightGray
    }
    
    // could possibly use onAppear() to do the shuffling each time the study activity loads
    
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
                            // this shrinks the gray area
//                            .frame(height: geometry.size.height - 50)
                        }
                        .frame(height: geometry.size.height)
                    }
                    .frame(height: 400)  // Set fixed height for the flashcards container
                }.padding(.horizontal)
                
                HStack {
                    Button {
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
                        .frame(width: 150)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(SharedConstants.cornerRadius)
                    }
                    
                    
                    Spacer()
                    
                    Button {
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
                        .frame(width: 150)
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


}
