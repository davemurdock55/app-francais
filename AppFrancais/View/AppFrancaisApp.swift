//
//  AppFrancaisApp.swift
//  AppFrancais
//
//  Created by David Murdock on 10/10/24.
//

import SwiftUI

@main
struct AppFrancaisApp: App {
    var body: some Scene {
        WindowGroup {
            LessonsView().environmentObject(LessonsViewModel())
        }
    }
}
