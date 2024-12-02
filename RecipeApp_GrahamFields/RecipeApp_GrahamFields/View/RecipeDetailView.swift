//
//  RecipeDetailView.swift
//  RecipeApp_GrahamFields
//
//  Created by Graham Fields on 12/2/24.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    @State private var isImageVisible = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Animated image with fade-in effect
                if let largeImageURL = recipe.photoURLLarge {
                    AsyncImage(url: largeImageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 300)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(15)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                .opacity(isImageVisible ? 1 : 0) // Initial opacity for animation
                                .animation(.easeIn(duration: 0.5), value: isImageVisible) // Animation for image
                                .onAppear {
                                    withAnimation {
                                        isImageVisible = true
                                    }
                                }
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.gray)
                                .cornerRadius(15)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }

                // Title with shadow and scale animation
                Text(recipe.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 2, y: 2)
                    .scaleEffect(isImageVisible ? 1.1 : 1) // Scale effect when image appears
                    .animation(.easeInOut(duration: 0.5), value: isImageVisible)

                // Cuisine type with a fade-in animation
                Text("Cuisine: \(recipe.cuisine)")
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .opacity(isImageVisible ? 1 : 0)
                    .animation(.easeIn(duration: 0.3).delay(0.2), value: isImageVisible) // Delayed fade-in

                // Button to view recipe source with an animation
                if let sourceURL = recipe.sourceURL {
                    Link("View Recipe Source", destination: sourceURL)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                        .scaleEffect(isImageVisible ? 1 : 0.9) // Scale effect
                        .animation(.spring(), value: isImageVisible) // Spring animation
                        .padding(.bottom, 10)
                }

                // Button to watch on YouTube with an animation
                if let youtubeURL = recipe.youtubeURL {
                    Link("Watch on YouTube", destination: youtubeURL)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                        .scaleEffect(isImageVisible ? 1 : 0.9)
                        .animation(.spring(), value: isImageVisible)
                }
            }
            .padding()
            .background(Color(UIColor.systemBackground).opacity(0.95))
            .cornerRadius(15)
            .shadow(radius: 10)
            .padding()
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
