//
//  CompleteButton.swift
//  AppFrancais
//
//  Created by David Murdock on 10/22/24.
//

import SwiftUI

struct CompleteButtonView: View {
    let activity: String
    let isCompleted: Bool
    let handlePress: () -> Void
    
    var body: some View {
        Button {
            withAnimation(.snappy(duration: 0.5)) {
                handlePress()
            }
        } label: {
            !isCompleted ? Label("MARK \(activity.uppercased()) AS COMPLETE", systemImage: "checkmark.circle") : Label("MARK \(activity.uppercased()) AS INCOMPLETE", systemImage: "checkmark.circle.fill")
                
        }
        .padding()
        .background(!isCompleted ? Color.green : Color.gray)
        .foregroundColor(.white)
        .fontWeight(.bold)
        .cornerRadius(10)
        .opacity(!isCompleted ? 1.0 : 0.5)
    }
}
