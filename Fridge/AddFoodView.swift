//
//  AddFoodView.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-15.
//

import SwiftUI

struct AddFoodView: View {
    @State private var foodName = ""
    @State private var foodType: FoodType = .other
    @State private var expiryDate = Calendar.current.date(byAdding: .day, value: 5, to: .now)!
    @State private var recommendDaysBeforeExpiry: Int?
    @Binding var showAddMenu: Bool
    var body: some View {
        NavigationView {
            Form {
                TextField("Food Name", text: $foodName)
                Picker("Food Type", selection: $foodType) {
                    Text("Other").tag(FoodType.other)
                    Text("Frozen").tag(FoodType.frozen)
                    Text("Vegetable").tag(FoodType.vegetable)
                    Text("Dairy").tag(FoodType.dairy)
                    Text("Bread").tag(FoodType.bread)
                    Text("Fresh Meat").tag(FoodType.freshMeat)
                    Text("Fruit").tag(FoodType.fruit)
                }
                VStack(spacing: 4) {
                    DatePicker("Expiry Date", selection: $expiryDate, displayedComponents: .date)
                    if recommendDaysBeforeExpiry != nil {
                        HStack {
                            Spacer()
                            Text("Recommended: ")
                                .foregroundColor(.secondary)
                            Button("\(recommendDaysBeforeExpiry!) days later") {
                                expiryDate = Calendar.current.date(byAdding: .day,
                                                                   value: recommendDaysBeforeExpiry!,
                                                                   to: .now)!
                                recommendDaysBeforeExpiry = nil
                            }
                        }
                    }
                }
                .padding(.vertical, recommendDaysBeforeExpiry == nil ? 0 : 2)
            }
            .onChange(of: foodType) { newType in
                Task.detached(priority: .utility) {
                    recommendDaysBeforeExpiry = try await Network.shared.recommendedExpiryForFood(ofType: newType)
                }
            }
            .navigationTitle("Add New Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        showAddMenu = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", action: validatesAndAddItem)
                }
            }
        }
    }
    
    func validatesAndAddItem() {
        showAddMenu = false
        // TODO: validation & addition
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView(showAddMenu: .constant(true))
    }
}
