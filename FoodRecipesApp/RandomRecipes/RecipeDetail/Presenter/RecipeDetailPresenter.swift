//
//  RecipeDetailPresenter.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 11.09.2022.
//

import Foundation

//MARK: - RecipeDetail input protocol
protocol RecipeDetailInput: AnyObject {
    //func setRecipe()
}

//MARK: - RecipeDetail output protocol
protocol RecipeDetailOutput: AnyObject {
    var recipe: Recipe? { get set }
    var imageData: Data? { get set }
    init(view: RecipeDetailInput, storageManager: StorageManager, router: Router, recipe: Recipe?)
    func showInstructions(recipe: Recipe?)
    func saveRecipe()
    func numberOfRows() -> Int
}

//MARK: - RecipeDetailPresenter
class RecipeDetailPresenter: RecipeDetailOutput {
    weak var view: RecipeDetailInput!
    let storageManager: StorageManager!
    let router: Router!
    var recipe: Recipe?
    var imageData: Data?
    
    required init(view: RecipeDetailInput, storageManager: StorageManager, router: Router, recipe: Recipe?) {
        self .view = view
        self.storageManager = storageManager
        self.router = router
        self .recipe = recipe
    }
    
    func numberOfRows() -> Int {
        recipe?.extendedIngredients.count ?? 0
    }
    
    func saveRecipe() {
        DispatchQueue.main.async { [weak self] in
            self?.storageManager.save(
                title: self?.recipe?.title ?? "",
                instruction: self?.recipe?.instructions ?? "",
                imageUrlString: self?.recipe?.image ?? "",
                recipe: (self?.recipe)!
            )
        }
    }
    
    func showInstructions(recipe: Recipe?) {
        router.showInstructions(recipe: recipe)
    }
}
