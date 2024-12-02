//
//  RecipeService.swift
//  RecipeApp_GrahamFields
//
//  Created by Graham Fields on 12/2/24.
//

import Foundation

class RecipeService: RecipeFetching {
    // Asynchronous method with a completion handler
    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                completion(.success(recipeResponse.recipes))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    // Async/Await method
    func fetchRecipes() async throws -> [Recipe] {
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
        return recipeResponse.recipes
    }
}
