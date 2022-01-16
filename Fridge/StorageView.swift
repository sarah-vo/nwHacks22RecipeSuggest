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
                await Network.shared.addItemToCart(byUserWithID: "1111111111", item: Food.sampleData1[0])
            }
        }
    }
}

struct StorageView_Previews: PreviewProvider {
    static var previews: some View {
        StorageView()
    }
}
