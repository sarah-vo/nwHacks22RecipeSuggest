//
//  RecipeView.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-15.
//

import SwiftUI

struct RecipeView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(0 ..< 5) { item in
                        RecipeCard(
                            recipe: Recipe(id: 0, name: "Sample", imageURLString: "https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png")
                        )
                    }
                }
            }
            .navigationTitle("Recipe")
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}
