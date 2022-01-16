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
    var userID: UUID
    
    init(name: String, type: FoodType, datePurchased: Date?, daysBeforeExpire: Int?) {
        self.name = name
        self.type = type
        self.datePurchased = datePurchased
        self.daysBeforeExpire = daysBeforeExpire
        self.userID = Network.shared.userID
        
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
        
        #warning("This is temporarily disabled because the backend doesn't have a matching field.")
        datePurchased = nil // try container.decode(Date?.self, forKey: .datePurchased)
        
        daysBeforeExpire = try container.decode(Int?.self, forKey: .daysBeforeExpire)
        userID = try container.decode(UUID.self, forKey: .UUID)
    }
}

extension Food: Codable {
    enum CodingKeys: CodingKey {
        #warning("This is temporarily disabled because the backend doesn't have a matching field.")
        // case name, type, datePurchased, daysBeforeExpire, UUID
        
        case name, type, daysBeforeExpire, UUID
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        
        #warning("This is temporarily disabled because the backend doesn't have a matching field.")
        // try container.encode(datePurchased, forKey: .datePurchased)
        
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
    
    private let userIDKey = "hwHacks2022.userID"
    var userID: UUID {
        if let userID = UserDefaults.standard.string(forKey: userIDKey) {
            return UUID(uuidString: userID)!
        } else {
            let newUserID = UUID()
            UserDefaults.standard.set(newUserID.uuidString, forKey: userIDKey)
            Task { try await setUserId(newUserID.uuidString) }
            return newUserID
        }
//        UserDefaults.standard.removeObject(forKey: userIDKey)
//        return UUID()
    }
    
    let baseURL = URL(string: "http://127.0.0.1:8000")!
    
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
    
    func get<Q: Encodable, V: Decodable>(pathComponent: String, query: Q) async throws -> V {
        let url = baseURL.appendingPathComponent(pathComponent)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let httpBody = try JSONEncoder().encode(query)
        request.httpBody = httpBody
        print(jsonToString(jsonData: httpBody))
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedObject = try JSONDecoder().decode(V.self, from: data)
        return decodedObject
    }
    
    func get<V: Decodable>(pathComponent: String) async throws -> V {
        let url = baseURL.appendingPathComponent(pathComponent)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decodedObject = try JSONDecoder().decode(V.self, from: data)
        return decodedObject
    }
    
    func itemsInCart() async throws -> [Food] {
        #warning("This method should accepts only items with matching UUID.")
        return try await get(pathComponent: "/recipe_app/shoppinglistitem/")
    }
    
    func addItemToCart(item: Food) async throws {
        let _: Food = try await post(pathComponent: "/recipe_app/shoppinglistitem/", item: item)
    }
    
    private func jsonToString(jsonData: Data) -> String {
        let convertedString = String(data: jsonData, encoding: String.Encoding.utf8)
        return convertedString ?? "Unable to convert data."
    }
    
    func addItemsToCart(items: [Food]) async throws {
        
    }
    
    func removeItemFromCart(item: Food) async throws {
        
    }
    
    func removeItemsFromCart(item: [Food]) async throws {
        
    }
    
    func recommendedExpiryForFood(ofType foodType: FoodType) async throws -> Int {
        return 10
    }
    
    func favorite(recipe: Recipe) async throws {
        
    }
    
    func unfavorite(recipe: Recipe) async throws {
        
    }
    
    func allFavoritedRecipes() async throws {
        
    }
    
    func itemsInStorage() async throws -> [Food] {
        return Food.sampleData2
    }
    
    func removeItemFromStorage(_ food: Food) async throws {
        
    }
    
    func removeItemsFromStorage(_ foods: [Food]) async throws {
        
    }
    
    func addItemToStorage(_ food: Food) async throws {
        Food.sampleData2.append(food)
    }
    
    func addItemsToStorage(_ foods: [Food]) async throws {
        
    }
    
    private struct UUIDWrapper: Codable { let UUID: String }
    private func setUserId(_ uuidString: String) async throws {
        let uuidWrapper = UUIDWrapper(UUID: uuidString)
        print("Posting uuid: \(uuidString)")
        let returnedResult: UUID = try await post(pathComponent: "/recipe_app/user/", item: uuidWrapper)
        print("Returned result: \(returnedResult)")
    }
    
    // Function calls to external recipe API is not included yet
    
}
