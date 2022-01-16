//
//  StorageView.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-15.
//

import SwiftUI

struct StorageView: View {
    @State private var foodsPurchased: [Food]? = nil
    var body: some View {
        NavigationView {
            if let foodsPurchased = foodsPurchased {
                ScrollView {
                    LazyVStack {
                        ForEach(foodsPurchased) { food in
                            StorageRow(food: food)
                        }
                    }
                    .navigationTitle("Storage")
                }
            } else {
                ProgressView()
                    .onAppear {
                        Task.detached(priority: .userInitiated) {
                            foodsPurchased = try await Network.shared.itemsInStorage()
                        }
                    }
            }
        }
    }
}

struct StorageView_Previews: PreviewProvider {
    static var previews: some View {
        StorageView()
    }
}
