//
//  FavoriteRecipeDetailPresenter.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 18.09.2022.
//

import Foundation

//MARK: - RecipeDetail input protocol
protocol FavoriteRecipeDetailInput: AnyObject {
    func setRecipe()
}

//MARK: - RecipeDetail output protocol
protocol FavoriteRecipeDetailOutput: AnyObject {
    var savedRecipe: SavedRecipe? { get set }
    var imageData: Data? { get set }
    init(view: FavoriteRecipeDetailInput, storageManager: StorageManager, router: Router, savedRecipe: SavedRecipe?)
    func fetchImageData()
    func showInstructions(savedRecipe: SavedRecipe?)
}

//MARK: - RecipeDetailPresenter
class FavoriteRecipeDetailPresenter: FavoriteRecipeDetailOutput {
    weak var view: FavoriteRecipeDetailInput!
    //let networkManager: NetworkManager!
    let storageManager: StorageManager!
    let router: Router!
    var savedRecipe: SavedRecipe?
    var imageData: Data?
    
    required init(view: FavoriteRecipeDetailInput, storageManager: StorageManager, router: Router, savedRecipe: SavedRecipe?) {
        self .view = view
        //self.networkManager = networkManager
        self.storageManager = storageManager
        self.router = router
        self.savedRecipe = savedRecipe
        fetchImageData()
    }
    
    func fetchImageData() {
//        if let currentRecipe = savedRecipe {
//            networkManager.fetchImageData(urlString: currentRecipe.imageUrlString) { [weak self] result in
//                switch result {
//                case .success(let data):
//                    self?.imageData = data
//                    self?.view.setRecipe()
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//        }
    }
    
    func showInstructions(savedRecipe: SavedRecipe?) {
        //router.showInstructions(recipe: savedRecipe)
    }
}

