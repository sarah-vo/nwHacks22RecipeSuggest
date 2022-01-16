//
//  CartRow.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-15.
//

import SwiftUI

struct CartRow: View {
    @ObservedObject var food: Food
    @Binding var foodsInCart: [Food]?
    @Binding var foodsPurchased: [Food]?
    
    var body: some View {
        HStack {
            CompletionToggle(food: food)
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
    }
}

struct CartRow_Previews: PreviewProvider {
    static var previews: some View {
        CartRow(food: Food.sampleData1[0], foodsInCart: .constant(nil), foodsPurchased: .constant(nil))
    }
}
