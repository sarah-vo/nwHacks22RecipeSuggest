//
//  Network.swift
//  Fridge
//
//  Created by Yongqi Xu on 2022-01-15.
//

import Foundation
import SwiftUI

#warning("The models are here to be used as a reference for the backend. Move them to a separate file when done.")

enum FoodType: String, Codable {
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
    @Published var datePurchased: Date?
    var daysBeforeExpire: Int?
    var userID = UUID()
    
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
        Food(name: "Redbean Paste", type: .other, datePurchased: Date(), daysBeforeExpire: 10),
        Food(name: "Chicken Wings", type: .freshMeat, datePurchased: Date(), daysBeforeExpire: 5),
        Food(name: "Toast", type: .bread, datePurchased: Date(), daysBeforeExpire: 12),
    ]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(FoodType.self, forKey: .type)
        datePurchased = nil // try container.decode(Date?.self, forKey: .datePurchased)
        daysBeforeExpire = try container.decode(Int?.self, forKey: .daysBeforeExpire)
        userID = try container.decode(UUID.self, forKey: .UUID)
    }
}

extension Food: Codable {
    enum CodingKeys: CodingKey {
        case name, type, datePurchased, daysBeforeExpire, UUID
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(datePurchased, forKey: .datePurchased)
        try container.encode(daysBeforeExpire, forKey: .daysBeforeExpire)
        try container.encode(userID, forKey: .UUID)
    }
}

struct Recipe: Codable {
    let id: Int
    let name: String
    let imageURLString: String?
}

class Network {
    
    static let shared = Network()
    
    let baseURL = URL(string: "http://127.0.0.1:8000")!
    
    func itemsInCart(userID: String) async throws -> [Food] {
        return Food.sampleData1
    }
    
    func post<T: Encodable, V: Decodable>(pathComponent: String, item: T) async throws -> V {
        let url = baseURL.appendingPathComponent(pathComponent)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let httpBody = try JSONEncoder().encode(item)
        request.httpBody = httpBody
        print(jsonToString(jsonData: httpBody))
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedObject = try JSONDecoder().decode(V.self, from: data)
        return decodedObject
    }
    
    func addItemToCart(byUserWithID userID: String, item: Food) async throws {
        let _: Food = try await post(pathComponent: "/recipe_app/shoppinglistitem/", item: item)
    }
    
    func jsonToString(jsonData: Data){
        let convertedString = String(data: jsonData, encoding: String.Encoding.utf8)
        print(convertedString ?? "defaultvalue")
    }
    
    func addItemsToCart(byUserWithID userID: String, items: [Food]) async throws {
        
    }
    
    func removeItemFromCart(byUserWithID userID: String, item: Food) async throws {
        
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
