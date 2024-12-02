//
//  RecipeRow.swift
//  RecipeApp_GrahamFields
//
//  Created by Graham Fields on 12/2/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeRow: View {
    let recipe: Recipe

    var body: some View {
        HStack {
            if let photoURL = recipe.photoURLSmall {
                WebImage(url: photoURL)
                    .resizable()
                    .indicator(.activity)
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
            }
        }
    }
}

