//
//  RecipeDetailPresenter.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 11.09.2022.
//

import Foundation

protocol RecipeDetailInput: AnyObject {
    func setRecipe(recipe: Recipe?)
}

protocol RecipeDetailOutput: AnyObject {
    init(view: RecipeDetailInput, networkManager: NetworkManager, router: Router, recipe: Recipe?)
    func setRecipe()
}

class RecipeDetailPresenter: RecipeDetailOutput {
    weak var view: RecipeDetailInput!
    let networkManager: NetworkManager!
    let router: Router!
    var recipe: Recipe?
    
    required init(view: RecipeDetailInput, networkManager: NetworkManager, router: Router, recipe: Recipe?) {
        self .view = view
        self.networkManager = networkManager
        self.router = router
        self .recipe = recipe
    }
    
    func setRecipe() {
        view.setRecipe(recipe: recipe)
    }
}
