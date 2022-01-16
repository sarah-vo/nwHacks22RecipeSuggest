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
            VStack(alignment: .leading, spacing: 4) {
                Text(food.name)
                if let daysBeforeExpire = food.daysBeforeExpire {
                    let attributedString = try! AttributedString(markdown: "Expires in **\(daysBeforeExpire)** days after purchased.")
                    Text(attributedString)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.leading, 7)
            Spacer()
        }
        .padding(.vertical)
        .onChange(of: hasBeenPurchased) { hasBeenPurchased in
            food.datePurchased = hasBeenPurchased ? Date() : nil
        }
    }
}

struct CartRow_Previews: PreviewProvider {
    static var previews: some View {
        CartRow(food: Food.sampleData1[0])
    }
}
