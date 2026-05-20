//
//  ComponentRecognitionTest_1App.swift
//  ComponentRecognitionTest.1
//
//  Created by Reece Clem on 3/20/25.
//

import SwiftUI

@main
struct ComponentViewGOApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ViewModel())
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfied")
                }
        }
    }
}
