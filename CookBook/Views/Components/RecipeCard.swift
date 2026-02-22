//
//  RecipeCard.swift
//  CookBook
//
//  Created by Mandy Nguyen on 11.02.26.
//

import SwiftUI

struct RecipeCard: View {
    var recipe: Recipe
    
    var body: some View {
        VStack {
            if let imageData = recipe.imageData,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(width: 160, height: 217, alignment: .top)
        .overlay(alignment: .bottom) {
            Text(recipe.name)
                .font(.headline)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 3, x: 0, y: 0)
                .frame(maxWidth: 136)
                .padding()
        }
        .background(
            LinearGradient(
                colors: [Color.gray.opacity(0.3), Color.gray],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
    }
}

#Preview {
    RecipeCard(recipe: Recipe.all[0])
}
