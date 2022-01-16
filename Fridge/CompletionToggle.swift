//
//  CompletionToggle.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-15.
//

import SwiftUI

struct CompletionToggle: View {
    
    @ObservedObject var food: Food
    
    private let outerDiameter: CGFloat = 28
    private let innerDiameter: CGFloat = 22
    
    var body: some View {
        ZStack {
            if food.datePurchased != nil {
                Circle()
                    .frame(width: innerDiameter, height: innerDiameter, alignment: .center)
            }
            Circle()
                .stroke(lineWidth: 2.0)
                .frame(width: outerDiameter, height: outerDiameter, alignment: .center)
        }
        .foregroundColor(.accentColor)
        .onTapGesture {
            food.datePurchased = Date()
            // TODO: Add vibration & accessibility support
        }
    }
}

struct CompletionToggle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CompletionToggle(food: Food.sampleData2[0])
            CompletionToggle(food: Food.sampleData2[0])
        }
    }
}
