//
//  RecipesListViewPresenter.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 10.09.2022.
//

import Foundation

//MARK: - RecipesList input protocol
protocol RecipesListInput: AnyObject {
    func getRecipes()
}

//MARK: - RecipesList output protocol
protocol RecipesListOutput: AnyObject {
    var recipes: [Recipe]? { get set }
    var imageData: [Data]? { get set }
    init(view: RecipesListInput, networkManager: NetworkManager, router: Router)
    func fetchRecipes()
    func fetchImageData(recipes: [Recipe])
    func numberOfItems() -> Int
    func tapOnRecipe(recipe: Recipe?)
}

//MARK: - RecipesListViewPresenter
class RecipesListViewPresenter: RecipesListOutput {
    var imageData: [Data]?
    weak var view: RecipesListInput!
    let networkManager: NetworkManager!
    let router: Router!
    var recipes: [Recipe]?
    
    required init(view: RecipesListInput, networkManager: NetworkManager, router: Router) {
        self.view = view
        self.networkManager = networkManager
        self.router = router
        fetchRecipes()
    }
    
    func fetchRecipes() {
        networkManager.fetchData { [weak self] result in
            switch result {
            case .success(let foodRecipes):
                DispatchQueue.main.async {
                    self?.recipes = foodRecipes.recipes
                    self?.fetchImageData(recipes: foodRecipes.recipes)
                    self?.view.getRecipes()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchImageData(recipes: [Recipe]) {
        var data: [Data] = []
        for recipe in recipes {
            networkManager.fetchImageData(urlString: recipe.image ?? "") { result in
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
    
    func numberOfItems() -> Int {
        recipes?.count ?? 0
    }
    
    func tapOnRecipe(recipe: Recipe?) {
        router.showDetail(recipe: recipe)
    }
}
