//
//  TabBar.swift
//  CookBook
//
//  Created by Mandy Nguyen on 08.02.26.
//

import SwiftUI

struct TabBar: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
            
            CategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "square.fill.text.grid.1x2")
                }
                .tag(1)
            
            AddRecipeView(selectedTab: $selectedTab)
                .tabItem {
                    Label("New", systemImage: "plus")
                }
                .tag(2)
        }
    }
}

#Preview {
    TabBar()
        .environmentObject(RecipesViewModel())
}
