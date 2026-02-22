//
//  ContentView.swift
//  CookBook
//
//  Created by Mandy Nguyen on 08.02.26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabBar()
    }
}


#Preview {
    ContentView()
        .environmentObject(RecipesViewModel())
}
