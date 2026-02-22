//
//  CookBookApp.swift
//  CookBook
//
//  Created by Mandy Nguyen on 08.02.26.
//

import SwiftUI

@main
struct CookBookApp: App {
    @StateObject var recipesViewModel = RecipesViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(recipesViewModel)
        }
    }
}
