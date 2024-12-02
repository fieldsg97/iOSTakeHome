//
//  RecipeViewModel.swift
//  RecipeApp_GrahamFields
//
//  Created by Graham Fields on 12/2/24.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var errorMessage: String?
    @Published var isLoading = false

    private var cancellables: Set<AnyCancellable> = []
    private let service: RecipeFetching

    init(service: RecipeFetching = RecipeService()) {
        self.service = service
    }

    func fetchRecipes() {
        isLoading = true
        errorMessage = nil

        service.fetchRecipes { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedRecipes):
                    self?.recipes = fetchedRecipes
                case .failure(let error):
                    self?.errorMessage = "Failed to load recipes: \(error.localizedDescription)"
                }
                self?.isLoading = false
            }
        }
    }
}

