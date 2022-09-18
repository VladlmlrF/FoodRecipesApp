//
//  FavoriteRecipeDetailPresenter.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 18.09.2022.
//

import Foundation

//MARK: - FavoriteRecipeDetail input protocol
protocol FavoriteRecipeDetailInput: AnyObject {
    func setRecipe()
}

//MARK: - FavoriteRecipeDetail output protocol
protocol FavoriteRecipeDetailOutput: AnyObject {
    var savedRecipe: SavedRecipe? { get set }
    init(view: FavoriteRecipeDetailInput, storageManager: StorageManager, router: Router, savedRecipe: SavedRecipe?)
    func deleteRecipe()
}

//MARK: - FavoriteRecipeDetailPresenter
class FavoriteRecipeDetailPresenter: FavoriteRecipeDetailOutput {
    weak var view: FavoriteRecipeDetailInput!
    let storageManager: StorageManager!
    let router: Router!
    var savedRecipe: SavedRecipe?
    
    required init(view: FavoriteRecipeDetailInput, storageManager: StorageManager, router: Router, savedRecipe: SavedRecipe?) {
        self .view = view
        self.storageManager = storageManager
        self.router = router
        self.savedRecipe = savedRecipe
    }
    
    func deleteRecipe() {
        if let recipe = savedRecipe {
            storageManager.delete(recipe)
            router.back()
        }
    }
}

