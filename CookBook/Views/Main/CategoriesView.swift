//
//  CategoriesView.swift
//  CookBook
//
//  Created by Mandy Nguyen on 08.02.26.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var recipesVM: RecipesViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Category.allCases) { category in
                    NavigationLink {
                        ScrollView {
                            RecipeList(recipes: recipesVM.recipes.filter{ $0.category == category.rawValue })
                        }
                        .navigationTitle(category.rawValue)
                    } label: {
                        Text(category.rawValue)
                    }
                }
            }
                .navigationTitle(Text("Categories"))
        }
        .navigationViewStyle(.stack)
    }
}


#Preview {
    CategoriesView()
        .environmentObject(RecipesViewModel())
}
