//
//  RecipeListView.swift
//  RecipeApp_GrahamFields
//
//  Created by Graham Fields on 12/2/24.
//

import SwiftUI
import Combine

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.recipes) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    RecipeRow(recipe: recipe)
                }
            }
            .navigationTitle("Recipes")
            .onAppear {
                Task {
                    await viewModel.fetchRecipes()
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else if viewModel.recipes.isEmpty {
                    Text("No recipes available.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}

