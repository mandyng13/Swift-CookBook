//
//  AddRecipeView.swift
//  CookBook
//
//  Created by Mandy Nguyen on 11.02.26.
//

import SwiftUI
import PhotosUI

struct AddRecipeView: View {
    @EnvironmentObject var recipesVM: RecipesViewModel
    @Binding var selectedTab: Int
    
    var existingRecipe: Recipe?
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var imageData: Data?
    
    @State private var name: String = ""
    @State private var selectedCategory: Category = Category.none
    @State private var difficulty: Difficulty = Difficulty.easy
    @State private var totalTime: Int = 0
    @State private var ingredients: String = ""
    @State private var directions: String = ""
    @State private var tips: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    init(selectedTab: Binding<Int>, existingRecipe: Recipe? = nil) {
        self._selectedTab = selectedTab
        self.existingRecipe = existingRecipe
        if let recipe = existingRecipe {
            _name = State(initialValue: recipe.name)
            _selectedCategory = State(initialValue: Category(rawValue: recipe.category) ?? .none)
            _difficulty = State(initialValue: recipe.difficulty)
            _totalTime = State(initialValue: recipe.totalTime)
            _ingredients = State(initialValue: recipe.ingredients)
            _directions = State(initialValue: recipe.directions)
            _tips = State(initialValue: recipe.tips ?? "")
            _imageData = State(initialValue: recipe.imageData)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Recipe Name", text: $name)
                }
                
                Section(header: Text("Category")) {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(Category.allCases) { category in
                            Text(category.rawValue)
                                .tag(category)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Difficulty")) {
                    Picker("Difficulty", selection: $difficulty) {
                        ForEach(Difficulty.allCases) { difficulty in
                            Text(difficulty.rawValue)
                                .tag(difficulty)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.menu)
                }
                
                Section(header: Text("Total Time (min.)")) {
                    TextField("Total Time", value: $totalTime, format: .number)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Ingredients")) {
                    TextEditor(text: $ingredients)
                        .frame(minHeight: 60)
                }
                
                Section(header: Text("Directions")) {
                    TextEditor(text: $directions)
                        .frame(minHeight: 60)
                }
                
                Section(header: Text("Tips")) {
                    TextEditor(text: $tips)
                        .frame(minHeight: 60)
                }
                
                Section {
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        if let imageData,
                           let uiImage = UIImage(data: imageData) {

                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 180)
                                    .clipped()
                                    .cornerRadius(12)
                                
                                Button {
                                    self.imageData = nil
                                    self.selectedItem = nil
                                } label: {
                                    Image(systemName: "trash.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.white)
                                }
                                .padding(6)
                            }

                        } else {
                            Label("Add Photo", systemImage: "photo")
                        }
                    }
                }
            }
            .onChange(of: selectedItem) {
                Task {
                    imageData = try? await selectedItem?.loadTransferable(type: Data.self)
                }
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        goHome()
                    } label: {
                        Label("Cancel", systemImage: "xmark")
                            .labelStyle(.iconOnly)
                    }
                }
                ToolbarItem {
                    Button {
                        saveRecipe()
                        goHome()
                    } label: {
                        Label("Done", systemImage: "checkmark")
                            .labelStyle(.iconOnly)
                    }
                    .disabled(name.isEmpty)
                }
            })
            .navigationTitle(existingRecipe == nil ? "New Recipe" : "Edit Recipe")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
    }
}

#Preview {
    AddRecipeView(selectedTab: .constant(0))
        .environmentObject(RecipesViewModel())
}

extension AddRecipeView {
    private func saveRecipe() {
        let recipe = Recipe(
            id: existingRecipe?.id ?? UUID(),
            name: name,
            imageData: imageData,
            difficulty: difficulty,
            ingredients: ingredients,
            directions: directions,
            tips: tips.isEmpty ? nil : tips,
            category: selectedCategory.rawValue,
            totalTime: totalTime
        )
        
        if existingRecipe != nil {
            recipesVM.editRecipe(recipe)
        } else {
            recipesVM.addRecipe(recipe: recipe)
        }
    }

    
    private func goHome() {
        dismiss()
        selectedTab = 0
    }
}
