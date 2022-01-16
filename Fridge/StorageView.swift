//
//  StorageView.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-15.
//

import SwiftUI

struct StorageView: View {
    var body: some View {
        Button("Fire!") {
            Task {
                do {
                    try await Network.shared.addItemToCart(item: Food.sampleData1[1])
                } catch {
                    print(error)
                    print(error.localizedDescription)
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
