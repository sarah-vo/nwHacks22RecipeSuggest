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
        .onChange(of: food.datePurchased) { datePurchased in
            // TODO: Create a computed property for the new expiry date
            if datePurchased != nil {
                updateAndMoveFromCartToPurchased(item: food)
            } else {
                updateAndMoveFromPurchasedToCart(item: food)
            }
        }
    }
    
    func updateAndMoveFromCartToPurchased(item: Food) {
        foodsPurchased?.insert(item, at: 0)
        foodsInCart?.removeAll{ $0.id == item.id }
        
        Task.detached(priority: .background) {
            try await Network.shared.addItemToStorage(item, byUserWithID: await Network.shared.currentUserID())
            try await Network.shared.removeItemFromCart(byUserWithID: await Network.shared.currentUserID(), item: item)
        }
    }
    
    func updateAndMoveFromPurchasedToCart(item: Food) {
        foodsInCart?.insert(item, at: 0)
        foodsPurchased?.removeAll{ $0.id == item.id }
        
        Task.detached(priority: .background) {
            try await Network.shared.addItemToCart(byUserWithID: await Network.shared.currentUserID(), item: item)
            try await Network.shared.removeItemFromStorage(item, byUserWithID: await Network.shared.currentUserID())
        }
    }
}

struct CartRow_Previews: PreviewProvider {
    static var previews: some View {
        CartRow(food: Food.sampleData1[0], foodsInCart: .constant(nil), foodsPurchased: .constant(nil))
    }
}
