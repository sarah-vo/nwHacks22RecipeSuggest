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
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
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
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAddMenu = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .bottomBar) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.ultraThinMaterial)
                                .blendMode(colorScheme == .dark ? .normal : .overlay)
                            HStack {
                                Text("Done shopping?")
                                Spacer()
                                Button("Remove Purchased") {
                                    // TODO:
                                }
                                .buttonStyle(.bordered)
                            }
                            .padding()
                        }
                        .offset(x: 0.0, y: -30.0)
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
