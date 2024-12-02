//
//  RecipeFetching.swift
//  RecipeApp_GrahamFields
//
//  Created by Graham Fields on 12/4/24.
//

import Foundation

protocol RecipeFetching {
    func fetchRecipes() async throws -> [Recipe]
    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void)
}

