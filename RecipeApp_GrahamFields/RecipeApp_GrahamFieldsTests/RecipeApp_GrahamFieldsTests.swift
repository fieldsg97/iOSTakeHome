//
//  RecipeApp_GrahamFieldsTests.swift
//  RecipeApp_GrahamFieldsTests
//
//  Created by Graham Fields on 12/2/24.
//

import XCTest
@testable import RecipeApp_GrahamFields
import Foundation

/// Mock implementation of RecipeServiceProtocol
struct MockRecipeService: RecipeFetching {
    var stubbedResult: Result<[Recipe], Error>?

    func fetchRecipes() async throws -> [Recipe] {
        if let result = stubbedResult {
            switch result {
            case .success(let recipes):
                return recipes
            case .failure(let error):
                throw error
            }
        }
        throw NSError(domain: "Mock Error", code: -1, userInfo: nil)
    }

    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        if let result = stubbedResult {
            completion(result)
        } else {
            completion(.failure(NSError(domain: "Mock Error", code: -1, userInfo: nil)))
        }
    }
}


final class RecipeApp_GrahamFieldsTests: XCTestCase {
    func testFetchRecipesSuccess() async throws {
        // Arrange
        let mockService = MockRecipeService(
            stubbedResult: .success([
                Recipe(
                    id: UUID(),
                    name: "Test Recipe",
                    cuisine: "Italian",
                    photoURLSmall: nil,
                    photoURLLarge: nil,
                    sourceURL: nil,
                    youtubeURL: nil
                )
            ])
        )

        // Act
        let viewModel = await RecipeViewModel(service: mockService)
        await viewModel.fetchRecipes()

        // Assert
        // Use await to access MainActor-isolated properties
        await MainActor.run {
            XCTAssertEqual(viewModel.recipes.count, 1, "Expected 1 recipe in the list.")
            XCTAssertEqual(viewModel.recipes.first?.name, "Test Recipe", "Expected the recipe name to match 'Test Recipe'.")
            XCTAssertNil(viewModel.errorMessage, "Error message should be nil on success.")
        }
    }

    func testFetchRecipesFailure() async throws {
        // Arrange
        let mockService = MockRecipeService(
            stubbedResult: .failure(NSError(domain: "TestError", code: -1, userInfo: nil))
        )

        // Act
        let viewModel = await RecipeViewModel(service: mockService)
        await viewModel.fetchRecipes()

        // Assert
        await MainActor.run {
            XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes list should be empty on failure.")
            XCTAssertNotNil(viewModel.errorMessage, "Error message should not be nil on failure.")
            XCTAssertTrue(
                viewModel.errorMessage?.contains("TestError") ?? false,
                "Expected error message to contain 'TestError'."
            )
        }
    }
}
