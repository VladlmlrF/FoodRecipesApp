//
//  Food.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 15.09.2022.
//

import Foundation
import RealmSwift

class SavedRecipe: Object {
    @Persisted var title = ""
    @Persisted var instruction = ""
    @Persisted var ingredients = List<FoodIngredient>()
    @Persisted var imageUrlString = ""
}

class FoodIngredient: Object {
    @Persisted var ingredient = ""
}
