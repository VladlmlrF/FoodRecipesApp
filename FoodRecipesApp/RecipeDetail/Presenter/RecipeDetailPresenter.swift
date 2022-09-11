//
//  RecipeDetailPresenter.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 11.09.2022.
//

import Foundation

protocol RecipeDetailInput: AnyObject {
    func setRecipe()
}

protocol RecipeDetailOutput: AnyObject {
    var recipe: Recipe? { get set }
    var imageData: Data? { get set }
    init(view: RecipeDetailInput, networkManager: NetworkManager, router: Router, recipe: Recipe?)
    func fetchImageData()
}

class RecipeDetailPresenter: RecipeDetailOutput {
    weak var view: RecipeDetailInput!
    let networkManager: NetworkManager!
    let router: Router!
    var recipe: Recipe?
    var imageData: Data?
    
    required init(view: RecipeDetailInput, networkManager: NetworkManager, router: Router, recipe: Recipe?) {
        self .view = view
        self.networkManager = networkManager
        self.router = router
        self .recipe = recipe
        fetchImageData()
    }
    
    func fetchImageData() {
        if let currentRecipe = recipe {
            networkManager.fetchImageData(recipe: currentRecipe) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.imageData = data
                    self?.view.setRecipe()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
