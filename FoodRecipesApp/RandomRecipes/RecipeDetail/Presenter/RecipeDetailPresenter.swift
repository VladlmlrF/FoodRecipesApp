//
//  RecipeDetailPresenter.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 11.09.2022.
//

import Foundation

//MARK: - RecipeDetail input protocol
protocol RecipeDetailInput: AnyObject {
    func setRecipe()
}

//MARK: - RecipeDetail output protocol
protocol RecipeDetailOutput: AnyObject {
    var recipe: Recipe? { get set }
    var imageData: Data? { get set }
    init(view: RecipeDetailInput, networkManager: NetworkManager, storageManager: StorageManager, router: Router, recipe: Recipe?)
    func fetchImageData()
    func showInstructions(recipe: Recipe?)
    func saveRecipe()
}

//MARK: - RecipeDetailPresenter
class RecipeDetailPresenter: RecipeDetailOutput {
    weak var view: RecipeDetailInput!
    let networkManager: NetworkManager!
    let storageManager: StorageManager!
    let router: Router!
    var recipe: Recipe?
    var imageData: Data?
    
    required init(view: RecipeDetailInput, networkManager: NetworkManager, storageManager: StorageManager, router: Router, recipe: Recipe?) {
        self .view = view
        self.networkManager = networkManager
        self.storageManager = storageManager
        self.router = router
        self .recipe = recipe
        fetchImageData()
    }
    
    func fetchImageData() {
        if let currentRecipe = recipe {
            networkManager.fetchImageData(urlString: currentRecipe.image ?? "") { [weak self] result in
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
