//
//  HomeView.swift
//  CookBook
//
//  Created by Mandy Nguyen on 08.02.26.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var recipesVM: RecipesViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                RecipeList(recipes: recipesVM.recipes)
            }
            .navigationTitle("My Recipes")
        }
        .navigationViewStyle(.stack)
    }
}


#Preview {
    HomeView()
        .environmentObject(RecipesViewModel())
}
