//
//  RecipeView.swift
//  CookBook
//
//  Created by Mandy Nguyen on 11.02.26.
//

import SwiftUI

struct RecipeView: View {
    var recipe: Recipe
    
    @State private var showEdit = false
    @State private var showDeleteAlert = false
    @EnvironmentObject var recipesVM: RecipesViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            ZStack {
                if let imageData = recipe.imageData,
                   let uiImage = UIImage(data: imageData) {
                    
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: 300)
                        .clipped()
                    
                } else {
                    LinearGradient(
                        colors: [Color.gray.opacity(0.3), Color.gray],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            .frame(height: 300)
            .background(
                LinearGradient(
                    colors: [Color.gray.opacity(0.3), Color.gray],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipped()
            
            VStack(spacing: 30) {
                Text(recipe.name)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                
                VStack(alignment: .leading, spacing: 40) {
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Difficulty: \(recipe.difficulty.rawValue.capitalized)")
                        Text("Total Time: \(recipe.totalTime) Min.")
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredients")
                            .font(.headline)
                        
                        ForEach(recipe.ingredients.components(separatedBy: "\n"), id: \.self) { ingredient in
                            HStack(alignment: .top, spacing: 5) {
                                Text("•")
                                Text(ingredient)
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Directions")
                            .font(.headline)
                        
                        ForEach(Array(recipe.directions.components(separatedBy: "\n").enumerated()), id: \.offset) { index, step in
                                Text("\(index + 1). \(step)")
                            }
                    }
                    
                    if let tips = recipe.tips, !tips.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Tips")
                                .font(.headline)
                            
                            ForEach(recipe.tips?.components(separatedBy: "\n") ?? [""], id: \.self) { tip in
                                HStack(alignment: .top, spacing: 5) {
                                    Text("•")
                                    Text(tip)
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
            Button(role: .destructive) {
                showDeleteAlert = true
            } label: {
                Text("Delete Recipe")
                    .frame(maxWidth: .infinity)
            }
            .padding(.top, 20)
            .padding(.bottom, 30)
        }
        .ignoresSafeArea(.container, edges: .top)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showEdit = true
                } label: {
                    Image(systemName: "pencil")
                }
            }
        }
        .sheet(isPresented: $showEdit) {
            AddRecipeView(selectedTab: .constant(0),existingRecipe: recipe)
                .environmentObject(recipesVM)
        }
        .alert("Delete this recipe?", isPresented: $showDeleteAlert) {
            Button("Yes, delete", role: .destructive) {
                deleteRecipe()
            }
            
            Button("No, keep it", role: .cancel) { }
        } message: {
            Text("This action cannot be undone.")
        }
    }
}

#Preview {
    RecipeView(recipe: Recipe.all[1])
}

extension RecipeView {
    private func deleteRecipe() {
        recipesVM.deleteRecipe(recipe)
        dismiss()
    }
}
