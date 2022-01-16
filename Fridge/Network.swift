//
//  Network.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-15.
//

import Foundation
import SwiftUI

#warning("The models are here to be used as a reference for the backend. Move them to a separate file when done.")

enum FoodType {
    case vegetable
    case frozen
    case freshMeat
    case dairy
    case bread
    case fruit
    case other
}

class Food: ObservableObject, Identifiable {
    var name: String
    var type: FoodType
    var datePurchased: Date?
    var daysBeforeExpire: Int?
    let id = UUID()
    
    init(name: String, type: FoodType, datePurchased: Date?, daysBeforeExpire: Int?) {
        self.name = name
        self.type = type
        self.datePurchased = datePurchased
        self.daysBeforeExpire = daysBeforeExpire
        
        if daysBeforeExpire == nil {
            Task {
                // TODO: Should we have a fall back option if the network is unavailable?
                self.daysBeforeExpire = try await Network.shared.recommendedExpiryForFood(ofType: type)
            }
        }
    }
    
    static var sampleData1 = [
        Food(name: "Egg", type: .dairy, datePurchased: nil, daysBeforeExpire: 7),
        Food(name: "Tomato", type: .vegetable, datePurchased: nil, daysBeforeExpire: 10),
        Food(name: "Stuffed Chicken", type: .frozen, datePurchased: nil, daysBeforeExpire: 30),
        Food(name: "Tofu", type: .other, datePurchased: nil, daysBeforeExpire: 20)
    ]
    
    static var sampleData2 = [
        Food(name: "Redbean Paste", type: .other, datePurchased: nil, daysBeforeExpire: 10),
        Food(name: "Chicken Wings", type: .freshMeat, datePurchased: nil, daysBeforeExpire: 5),
        Food(name: "Toast", type: .bread, datePurchased: nil, daysBeforeExpire: 12),
    ]
}

struct Recipe {
    let id: Int
    let name: String
    let imageURLString: String?
}

class Network {
    
    static let shared = Network()
    
    func itemsInCart(userID: String) async throws -> [Food] {
        return Food.sampleData1
    }
    
    func addItemToCart(byUserWithID userID: String, item: Food) async throws {
        
    }
    
    func addItemsToCart(byUserWithID userID: String, items: [Food]) async throws {
        
    }
    
    func removeItemFromCart(byUserWithID userID: String, item: Food) async throws {
        let removedItem = Food.sampleData1.removeLast()
        Food.sampleData2.append(removedItem)
    }
    
    func removeItemsFromCart(byUserWithID userID: String, item: [Food]) async throws {
        
    }
    
    func recommendedExpiryForFood(ofType foodType: FoodType) async throws -> Int {
        return 10
    }
    
    func favorite(recipe: Recipe, byUserWithID userID: String) async throws {
        
    }
    
    func unfavorite(recipe: Recipe, byUserWithID userID: String) async throws {
        
    }
    
    func allFavoritedRecipes(byUserWithID userID: String) async throws {
        
    }
    
    func itemsInStorage(userID: String) async throws -> [Food] {
        return Food.sampleData2
    }
    
    func removeItemFromStorage(_ food: Food, byUserWithID userID: String) async throws {
        
    }
    
    func removeItemsFromStorage(_ foods: [Food], byUserWithID userID: String) async throws {
        
    }
    
    func addItemToStorage(_ food: Food, byUserWithID userID: String) async throws {
        Food.sampleData2.append(food)
    }
    
    func addItemsToStorage(_ foods: [Food], byUserWithID userID: String) async throws {
        
    }
    
    func currentUserID() async throws -> String {
        return ""
    }
    
    // Function calls to external recipe API is not included yet
    
}
