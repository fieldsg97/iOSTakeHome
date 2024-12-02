//
//  README.swift
//  RecipeApp_GrahamFields
//
//  Created by Graham Fields on 12/4/24.
//

Focus Areas
Architecture
The app follows the MVVM (Model-View-ViewModel) design pattern, ensuring that the code is maintainable, scalable, and testable. The RecipeViewModel manages data fetching and state handling, while views handle user interactions and display.

Concurrency
Utilized Swift’s Combine framework for reactive data handling and asynchronous operations. The fetchRecipes() method in RecipeViewModel demonstrates the use of sink() to manage network responses and update the UI reactively.

UI/UX
Created a modern, user-friendly interface using SwiftUI components.
Implemented animations using withAnimation for transitions between views and AsyncImage for loading images with visual placeholders.
Added visual enhancements like rounded corners and shadows for a polished look.
Performance Optimization
Used image caching with SDWebImageSwiftUI to reduce network calls and load images efficiently.
Optimized network requests with error handling that provides fallback responses when data is unavailable or malformed.
Time Spent
Initial Planning & Architecture Design: 1 hours — Designed the app's structure, model definitions, and data flow.
Networking & API Integration: 2 hours — Implemented RecipeService to make network calls and parse JSON data.
UI/UX Development: 2 hours — Designed RecipeListView and RecipeDetailView, adding styling and animations.
Error Handling: 2 hours — Implemented error handling mechanisms for failed network requests and invalid data.
Testing & Debugging: 1 hours — Added unit tests and fixed any identified issues to improve app stability.
Total time spent: approximately 8 hours.

Trade-offs and Decisions
Complexity vs Simplicity: Focused on using only essential libraries and frameworks to keep the project simple and lightweight.
Feature Scope: Prioritized core functionality to build a solid MVP. Advanced features such as user authentication and user feedback were not included but could be added later.
Third-Party Libraries: Chose SDWebImageSwiftUI to handle images efficiently, which added dependency but significantly improved performance.
Weakest Part of the Project
The weakest part is the unit test coverage. Although RecipeViewModel has basic tests for data fetching, more comprehensive testing covering UI elements and complex interactions is needed.

External Code and Dependencies
SDWebImageSwiftUI: Used for image loading and caching.
Combine: Used for handling asynchronous operations and state updates.
Additional Information
Constraints Encountered: Working with AsyncImage required custom implementations to handle placeholder and error states.
Future Enhancements:
Adding offline data caching with Core Data or SQLite for better user experience.
Integrating search functionality to filter recipes by name, cuisine, etc.
Implementing a user profile to save favorite recipes.
Insights: Creating an app with Combine and SwiftUI offers a modern approach but can present challenges in handling more complex UI interactions and data flow.
Thank you for reviewing my project! I look forward to feedback and potential collaboration.
