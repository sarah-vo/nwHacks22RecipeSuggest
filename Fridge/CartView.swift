//
//  CartView.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-15.
//

import SwiftUI

struct CartView: View {
    @State private var foodsInCart: [Food]? = nil
    @State private var foodsPurchased: [Food]? = nil
    @State private var showAddMenu = false
    @State private var showPurchased = false
    var body: some View {
        NavigationView {
            if let foodsInCart = foodsInCart {
                List {
                    ForEach(foodsInCart) { food in
                        CartRow(food: food, foodsInCart: $foodsInCart, foodsPurchased: $foodsPurchased)
                    }
                }
                .navigationTitle("Shopping Cart")
                .toolbar {
                    Button {
                        showAddMenu = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $showAddMenu) {
                    AddFoodView(showAddMenu: $showAddMenu, cartToAdd: $foodsInCart)
                }
            } else {
                ProgressView()
                    .onAppear {
                        Task.detached(priority: .userInitiated) {
                            foodsInCart = try await Network.shared.itemsInCart()
                        }
                    }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
