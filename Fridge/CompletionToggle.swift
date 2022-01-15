//
//  CompletionToggle.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-15.
//

import SwiftUI

struct CompletionToggle: View {
    
    @Binding var hasBeenCompleted: Bool
    
    private let outerDiameter: CGFloat = 30
    private let innerDiameter: CGFloat = 24
    
    var body: some View {
        ZStack {
            if hasBeenCompleted {
                Circle()
                    .frame(width: innerDiameter, height: innerDiameter, alignment: .center)
            }
            Circle()
                .stroke(lineWidth: 2.0)
                .frame(width: outerDiameter, height: outerDiameter, alignment: .center)
        }
        .foregroundColor(.accentColor)
        .onTapGesture {
            hasBeenCompleted.toggle()
            // TODO: Add vibration
        }
    }
}

struct CompletionToggle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CompletionToggle(hasBeenCompleted: .constant(false))
            CompletionToggle(hasBeenCompleted: .constant(true))
        }
    }
}
