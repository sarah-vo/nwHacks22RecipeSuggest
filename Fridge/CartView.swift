//
//  CartView.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-15.
//

import SwiftUI

struct CartView: View {
    let foods: [Food]
    var body: some View {
        NavigationView {
            List {
                ForEach(foods) { food in
                    CartRow(food: food)
                }
            }
            .navigationTitle("Shopping Cart")
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(foods: Food.sampleData)
    }
}
