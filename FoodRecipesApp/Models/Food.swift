//
//  Food.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 15.09.2022.
//

import Foundation
import RealmSwift

class Food: Object {
    @Persisted var title = ""
    @Persisted var instruction = ""
    @Persisted var ingredients = List<String>()
    @Persisted var imageData = Data()
}
