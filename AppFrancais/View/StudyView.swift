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
    
    @State private var currentIndex = 0
    
    init(lesson: LessonsModel.Lesson) {
        self.lesson = lesson
        UIPageControl.appearance().currentPageIndicatorTintColor = .gray
        UIPageControl.appearance().pageIndicatorTintColor = .lightGray
    }
    
    var body: some View {
        VStack {
//            Text("Study")
//                .font(.largeTitle)
            Text("\(lesson.name)").font(.largeTitle)
            
            TabView(selection: $currentIndex) {
                ForEach(lesson.vocabList.indices, id: \.self) { index in
                    FlashcardView(vocab: lesson.vocabList[index])
                        .tag(index)
                }
                .padding()
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .accentColor(.red)
            .background(Constants.flashCardsBackgroundColor)
            .cornerRadius(10)
            .padding()
            
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
                    .cornerRadius(10)
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
                    .cornerRadius(10)
                }
                
            }.padding()
            
            
            Spacer()
            
            // Uncomment and modify the below if you have a CompleteButtonView for Study completion
            // CompleteButtonView(
            //     isCompleted: lesson.study.isStudyCompleted,
            //     handlePress: { lessonViewModel.handleStudyCompleteTap(num: lesson.num) }
            // )
        }
    }
    
    // MARK: - Drawing Constants
    private struct Constants {
        static let flashCardsBackgroundColor: Color = Color(red: 0.95, green: 0.95, blue: 0.95)
    }
    
}
