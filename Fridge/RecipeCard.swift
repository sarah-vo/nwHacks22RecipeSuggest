//
//  RecipeCard.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-16.
//

import SwiftUI

// TODO: Improve this implementation
struct RecipeCard: View {
    var body: some View {
        ZStack {
            Image("recipe-demo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 40, height: 450)
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Lemon Wrap")
                            .font(.title)
                            .bold()
                        Text("Mexican Food")
                    }
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
        RecipeCard()
    }
}
