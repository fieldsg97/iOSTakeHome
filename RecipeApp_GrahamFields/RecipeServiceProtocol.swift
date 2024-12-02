//
//  RecipeServiceProtocol.swift
//  RecipeApp_GrahamFields
//
//  Created by Graham Fields on 12/2/24.
//

protocol RecipeServiceProtocol {
    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void)
}

