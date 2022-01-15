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

struct Food {
    var name: String
    var type: FoodType
    var datePurchased: Date
    var expiryDate: Date?
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
    
    func recommendedExpiryForFood(ofType foodType: FoodType) async throws -> Date {
        return Date()
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
