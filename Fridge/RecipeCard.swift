//
//  RecipeCard.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-16.
//

import SwiftUI

// TODO: Improve this implementation
struct RecipeCard: View {
    let recipe: Recipe
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: recipe.imageURLString ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 450)
            } placeholder: {
                ProgressView()
            }
            
            VStack {
                HStack {
                    Text(recipe.name)
                        .font(.title)
                        .bold()
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding()
                .padding(.vertical, 20)
                .background(.thickMaterial)
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: 450)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.25), radius: 10.0, x: 0.0, y: 10.0)
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCard(recipe: Recipe(id: 0, name: "Sample", imageURLString: "https://developer.apple.com/assets/elements/icons/swiftui/swiftui-96x96_2x.png"))
    }
}
