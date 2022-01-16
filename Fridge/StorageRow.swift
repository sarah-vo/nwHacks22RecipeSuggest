//
//  StorageRow.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-16.
//

import SwiftUI

struct StorageRow: View {
    @ObservedObject var food: Food
    @Environment(\.pixelLength) var pixelLength: CGFloat
    var body: some View {
        ZStack {
            Color(uiColor: .systemBackground)
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(food.name)
                            .font(.headline)
                        let numberOfDaysLeft = numberOfDaysLeft(from: food.datePurchased!, toDaysLater: food.daysBeforeExpire!)
                        Text("\(numberOfDaysLeft) Days Before Expiry")
                            .foregroundColor(daysLeftLabelColor(forFoodPurchasedOn: food.datePurchased!,
                                                                beforeExpiryIn: food.daysBeforeExpire!))
                            .font(.caption)
                        Text("Purchased on \(formattedDate(food.datePurchased))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Button(action: finishedItem) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.largeTitle)
                    }
                    Button(action: finishedItemAndAddToCart) {
                        Image(systemName: "cart.circle.fill")
                            .font(.largeTitle)
                    }
                    Image(systemName: "chevron.forward")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                Color(uiColor: .separator)
                    .frame(maxWidth: .infinity, maxHeight: pixelLength)
                    .padding(.leading)
            }
        }
        .onTapGesture {
            print("Navigating.")
        }
    }
    
    private func formattedDate(_ date: Date?) -> String {
        guard let date = date else {
            return "unknown"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    private func daysLeftLabelColor(forFoodPurchasedOn datePurchased: Date, beforeExpiryIn days: Int) -> Color {
        let sevenDaysBefore = Calendar.current.date(byAdding: .day, value: days - 7, to: datePurchased)!
        guard datePurchased > sevenDaysBefore else { return .purple }
        let fourDaysBefore = Calendar.current.date(byAdding: .day, value: days - 4, to: datePurchased)!
        guard datePurchased > fourDaysBefore else { return .orange }
        return .pink
    }
    
    private func numberOfDaysLeft(from fromDate: Date, toDaysLater days: Int) -> Int {
        let daysLater = Calendar.current.date(byAdding: .day, value: days, to: fromDate)!
        return Calendar.current.dateComponents([.day], from: fromDate, to: daysLater).day!
    }
    
    private func finishedItem() {
        print("Finished item.")
    }
    
    private func finishedItemAndAddToCart() {
        print("Finished and add to cart.")
    }
}

struct StorageRow_Previews: PreviewProvider {
    static var previews: some View {
        StorageRow(food: Food.sampleData2[0])
            .preferredColorScheme(.dark)
    }
}
