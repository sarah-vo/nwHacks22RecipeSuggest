//
//  ContentView.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RecipeView()
                .tabItem {
                    Text("Recipe")
                    Image(systemName: "fork.knife")
                }
            StorageView()
                .tabItem {
                    Text("Storage")
                    Image(systemName: "takeoutbag.and.cup.and.straw")
                }
            CartView()
                .tabItem {
                    Text("Cart")
                    Image(systemName: "cart")
                }
        }
        .tint(.accentColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
