//
//  RecipesViewModel.swift
//  CookBook
//
//  Created by Mandy Nguyen on 12.02.26.
//

import Foundation
import Combine

class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = [] {
        didSet {
            saveRecipes()
        }
    }
    
    private let userDefaultsKey = "recipes"
    
    init() {
        loadRecipes()
    }
    
    // MARK: - CRUD
    func addRecipe(recipe: Recipe) {
        recipes.append(recipe)
    }
    
    func editRecipe(_ recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index] = recipe
        }
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        recipes.removeAll { $0.id == recipe.id }
    }
    
    // MARK: - PERSISTENCE
    private func saveRecipes() {
        do {
            let data = try JSONEncoder().encode(recipes)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            print("Error saving recipes: \(error)")
        }
    }
    
    private func loadRecipes() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            recipes = Recipe.all
            return
        }
        
        do {
            recipes = try JSONDecoder().decode([Recipe].self, from: data)
        } catch {
            print("Error loading recipes: \(error)")
            recipes = Recipe.all
        }
    }
}
