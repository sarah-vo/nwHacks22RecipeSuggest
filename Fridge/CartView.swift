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
            VStack {
                if let foodsInCart = foodsInCart {
                    List {
                        Section("In Cart") {
                            ForEach(foodsInCart) { food in
                                CartRow(food: food, foodsInCart: $foodsInCart, foodsPurchased: $foodsPurchased)
                            }
                        }
                        
                        if showPurchased {
                            Section("Purchased") {
                                if let foodsPurchased = foodsPurchased {
                                    ForEach(foodsPurchased) { food in
                                        CartRow(food: food, foodsInCart: $foodsInCart, foodsPurchased: $foodsPurchased)
                                    }
                                } else {
                                    ProgressView()
                                        .onAppear {
                                            Task.detached(priority: .userInitiated) {
                                                async let userID = Network.shared.currentUserID()
                                                foodsPurchased = try await Network.shared.itemsInStorage(userID: userID)
                                            }
                                        }
                                }
                            }
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Shopping Cart")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Toggle(isOn: $showPurchased) {
                        Image(systemName: "checkmark.seal")
                    }
                    
                    if foodsInCart != nil {
                        Button {
                            showAddMenu = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddMenu) {
                AddFoodView(showAddMenu: $showAddMenu, cartToAdd: $foodsInCart)
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
