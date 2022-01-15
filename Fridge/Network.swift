//
//  Network.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-15.
//

import Foundation

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

class Food: ObservableObject {
    var name: String
    var type: FoodType
    var datePurchased: Date?
    var daysBeforeExpire: Int?
    
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
    
    static let sampleData = [
        Food(name: "Egg", type: .dairy, datePurchased: nil, daysBeforeExpire: 7)
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
        return []
    }
    
    func addItemToCart(byUserWithID userID: String, item: Food) {
        
    }
    
    func addItemsToCart(byUserWithID userID: String, items: [Food]) {
        
    }
    
    func recommendedExpiryForFood(ofType foodType: FoodType) async throws -> Int {
        return 0
    }
    
    func favorite(recipe: Recipe, byUserWithID userID: String) async throws {
        
    }
    
    func unfavorite(recipe: Recipe, byUserWithID userID: String) async throws {
        
    }
    
    func allFavoritedRecipes(byUserWithID userID: String) async throws {
        
    }
    
    func itemsInStorage(userID: String) async throws -> [Food] {
        return []
    }
    
    func removeItemFromStorage(_ food: Food, byUserWithID userID: String) async throws {
        
    }
    
    func removeItemsFromStorage(_ foods: [Food], byUserWithID userID: String) async throws {
        
    }
    
    func addItemToStorage(_ food: Food, byUserWithID userID: String) async throws {
        
    }
    
    func addItemsToStorage(_ foods: [Food], byUserWithID userID: String) async throws {
        
    }
    
    func currentUserID() async throws -> String {
        return ""
    }
    
    // Function calls to external recipe API is not included yet
    
}
