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
    @State private var daysBeforeExpiry = 3
    @State private var recommendDaysBeforeExpiry: Int?
    @Binding var showAddMenu: Bool
    @Binding var cartToAdd: [Food]?
    @State private var hasErrorInFields = false
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
                    Stepper("\(daysBeforeExpiry) Days Before Expiry", value: $daysBeforeExpiry)
                    if recommendDaysBeforeExpiry != nil {
                        HStack {
                            Spacer()
                            Text("Recommended: ")
                                .foregroundColor(.secondary)
                            Button("\(recommendDaysBeforeExpiry!) days") {
                                daysBeforeExpiry = recommendDaysBeforeExpiry!
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
            .alert("Invalid/Empty Fields", isPresented: $hasErrorInFields) {
                Button("OK", role: .cancel) { hasErrorInFields = false }
            }
        }
    }
    
    func validatesAndAddItem() {
        guard !foodName.isEmpty else {
            hasErrorInFields = true
            return
        }
        
        let newFood = Food(name: foodName, type: foodType, datePurchased: nil, daysBeforeExpire: daysBeforeExpiry)
        cartToAdd?.insert(newFood, at: 0)
        Task.detached(priority: .background) {
            try await Network.shared.addItemToCart(item: newFood)
        }
        
        showAddMenu = false
    }
}

struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView(showAddMenu: .constant(true), cartToAdd: .constant([]))
    }
}
