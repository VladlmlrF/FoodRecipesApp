//
//  FavoriteListViewPresenter.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 15.09.2022.
//

import Foundation

//MARK: - FavoriteList input protocol
protocol FavoriteListInput: AnyObject {
    func getRecipes()
}

//MARK: - FavoriteList output protocol
protocol FavoriteListOutput: AnyObject {
    var recipes: [Recipe]? { get set }
    var imageData: [Data]? { get set }
    init(view: FavoriteListInput, storageManager: StorageManager, router: Router)
    func fetchRecipes()
    func fetchImageData(recipes: [Recipe])
    func numberOfItems() -> Int
    func tapOnRecipe(recipe: Recipe?)
}

//MARK: - FavoriteListViewPresenter
class FavoriteListViewPresenter: FavoriteListOutput {
    var imageData: [Data]?
    weak var view: FavoriteListInput!
    let storageManager: StorageManager!
    let router: Router!
    var recipes: [Recipe]?
    
    required init(view: FavoriteListInput, storageManager: StorageManager, router: Router) {
        self.view = view
        self.storageManager = storageManager
        self.router = router
        fetchRecipes()
    }
    
    func fetchRecipes() {
        
    }
    
    func fetchImageData(recipes: [Recipe]) {
        
    }
    
    func numberOfItems() -> Int {
        recipes?.count ?? 0
    }
    
    func tapOnRecipe(recipe: Recipe?) {
        router.showDetail(recipe: recipe)
    }
}
