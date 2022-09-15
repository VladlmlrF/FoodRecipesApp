//
//  StorageManager.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 15.09.2022.
//

import Foundation
import RealmSwift


protocol StorageManager: AnyObject {
    
}

class StorageManagerImplementation: StorageManager {
    
    static let shared = StorageManagerImplementation()
    
    private init() {}
    
    let realm = try? Realm()
    
    func save(title: String, instruction: String, data: Data) {
        write {
            let food = Food()
            food.title = title
            food.instruction = instruction
            realm?.add(food)
        }
    }
    
    func delete(_ food: Food) {
        write {
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
