//
//  CompleteButton.swift
//  AppFrancais
//
//  Created by David Murdock on 10/22/24.
//

import SwiftUI

struct CompleteButtonView: View {
    
    let isCompleted: Bool
    let handlePress: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                handlePress()
            }
        } label: {
            !isCompleted ? Label("MARK AS COMPLETE", systemImage: "checkmark.circle") : Label("MARK AS INCOMPLETE", systemImage: "checkmark.circle.fill")
        }
        .padding()
        .background(!isCompleted ? Color.green : Color.gray)
        .foregroundColor(.white)
        .cornerRadius(10)
        .opacity(!isCompleted ? 1.0 : 0.5)
    }
}
