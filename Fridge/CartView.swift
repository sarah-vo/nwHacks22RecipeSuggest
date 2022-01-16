//
//  CartView.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-15.
//

import SwiftUI

struct CartView: View {
    @State private var foodsInCart: [Food]? = []
    @State private var showAddMenu = false
    @State private var showPurchased = false
    var body: some View {
        NavigationView {
            if let foodsInCart = foodsInCart {
                List {
                    ForEach(foodsInCart) { food in
                        CartRow(food: food)
                    }
                }
                .navigationTitle("Shopping Cart")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Toggle(isOn: $showPurchased) {
                            Image(systemName: "checkmark.seal")
                        }
                        
                        Button {
                            showAddMenu = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showAddMenu) {
                    AddFoodView(showAddMenu: $showAddMenu)
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task.detached(priority: .userInitiated) {
                foodsInCart = try await Network.shared.itemsInCart(userID: await Network.shared.currentUserID())
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
