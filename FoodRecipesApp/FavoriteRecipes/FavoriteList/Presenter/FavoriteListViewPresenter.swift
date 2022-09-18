//
//  FavoriteListViewPresenter.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 15.09.2022.
//

import Foundation
import RealmSwift

//MARK: - FavoriteList input protocol
protocol FavoriteListInput: AnyObject {
    func getRecipes()
}

//MARK: - FavoriteList output protocol
protocol FavoriteListOutput: AnyObject {
    var savedRecipeList: Results<SavedRecipe>? { get set }
    init(view: FavoriteListInput, storageManager: StorageManager, networkManager: NetworkManager, router: Router)
    func fetchRecipes()
    func numberOfItems() -> Int
    func tapOnRecipe(savedRecipe: SavedRecipe?)
    func fetchImage(savedRecipe: SavedRecipe, completion: @escaping(Data) -> ())
}

//MARK: - FavoriteListViewPresenter
class FavoriteListViewPresenter: FavoriteListOutput {
    var savedRecipeList: Results<SavedRecipe>?
    weak var view: FavoriteListInput!
    let storageManager: StorageManager!
    let networkManager: NetworkManager!
    let router: Router!
    
    required init(view: FavoriteListInput, storageManager: StorageManager, networkManager: NetworkManager, router: Router) {
        self.view = view
        self.storageManager = storageManager
        self.networkManager = networkManager
        self.router = router
        fetchRecipes()
    }
    
    func fetchRecipes() {
        savedRecipeList = storageManager.realm?.objects(SavedRecipe.self)
        view.getRecipes()
    }
    
    func fetchImage(savedRecipe: SavedRecipe, completion: @escaping(Data) -> ()) {
        networkManager.fetchImageData(urlString: savedRecipe.imageUrlString) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    completion(data)
                }
            case .failure(let error):
                print( error.localizedDescription)
            }
        }
    }
    
    func numberOfItems() -> Int {
        var numberOfItems = 0
        if let savedRecipeList = savedRecipeList, !savedRecipeList.isEmpty {
            numberOfItems = savedRecipeList.count
        }
        return numberOfItems
    }
    
    func tapOnRecipe(savedRecipe: SavedRecipe?) {
        router.showFavoriteDetail(savedRecipe: savedRecipe)
    }
}
