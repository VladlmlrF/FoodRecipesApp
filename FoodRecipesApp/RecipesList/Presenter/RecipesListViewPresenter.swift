//
//  RecipesListViewPresenter.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 10.09.2022.
//

import Foundation


protocol RecipesListInput: AnyObject {
    func success()
    func failure(error: Error)
}

protocol RecipesListOutput: AnyObject {
    var recipes: [Recipe]? { get set }
    var imageData: [Data]? { get set }
    init(view: RecipesListInput, networkManager: NetworkManager)
    func fetchRecipes()
    func fetchImageData(recipes: [Recipe])
}

class RecipesListViewPresenter: RecipesListOutput {
    var imageData: [Data]?
    weak var view: RecipesListInput!
    var networkManager: NetworkManager!
    var recipes: [Recipe]?
    
    required init(view: RecipesListInput, networkManager: NetworkManager) {
        self.view = view
        self.networkManager = networkManager
        fetchRecipes()
    }
    
    func fetchRecipes() {
        networkManager.fetchData { [weak self] result in
            switch result {
            case .success(let foodRecipes):
                self?.recipes = foodRecipes.recipes
                self?.fetchImageData(recipes: foodRecipes.recipes)
                self?.view.success()
            case .failure(let error):
                self?.view.failure(error: error)
            }
        }
    }
    
    func fetchImageData(recipes: [Recipe]) {
        var data: [Data] = []
        for recipe in recipes {
            networkManager.fetchImageData(recipe: recipe) { result in
                switch result {
                case .success(let fact):
                    data.append(fact)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        imageData = data
    }
}
