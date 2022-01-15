//
//  CartRow.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-15.
//

import SwiftUI

struct CartRow: View {
    @ObservedObject var food: Food
    @State private var hasBeenPurchased = false
    
    var body: some View {
        HStack {
            CompletionToggle(hasBeenCompleted: $hasBeenPurchased)
            Text(food.name)
                .padding(.leading, 7)
            Spacer()
        }
        .padding()
        .onChange(of: hasBeenPurchased) { hasBeenPurchased in
            food.datePurchased = hasBeenPurchased ? Date() : nil
        }
    }
}

struct CartRow_Previews: PreviewProvider {
    static var previews: some View {
        CartRow(food: Food.sampleData[0])
    }
}
