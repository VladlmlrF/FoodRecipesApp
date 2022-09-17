//
//  StorageManager.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 15.09.2022.
//

import Foundation
import RealmSwift


protocol StorageManager: AnyObject {
    func save(title: String, instruction: String, imageUrlString: String, recipe: Recipe)
    func delete(_ food: SavedRecipe)
    var realm: Realm? { get }
}

class StorageManagerImplementation: StorageManager {
    
//    static let shared = StorageManagerImplementation()
//
//    private init() {}
    
    var realm = try? Realm()
    
    func save(title: String, instruction: String, imageUrlString: String, recipe: Recipe) {
        write {
            let food = SavedRecipe()
            food.title = title
            food.instruction = instruction
            food.imageUrlString = imageUrlString
            
            for index in 0..<recipe.extendedIngredients.count {
                let foodIngredient = FoodIngredient()
                foodIngredient.ingredient = recipe.extendedIngredients[index].original
                food.ingredients.append(foodIngredient)
            }
            
            realm?.add(food)
        }
    }
    
    func delete(_ food: SavedRecipe) {
        write {
            realm?.delete(food.ingredients)
            realm?.delete(food)
        }
    }
    
    private func write(completion: () -> Void) {
        do {
            try realm?.write {
                completion()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
