//
//  AssemblyBuilder.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 10.09.2022.
//

import UIKit

protocol AssemblyBuilder {
    func createRecipesList(router: Router) -> UIViewController
    func createRecipeDetail(recipe: Recipe?, router: Router) -> UIViewController
    func createInstructions(recipe: Recipe?, router: Router) -> UIViewController
    func createFavoriteList(router: Router) -> UIViewController
    func createFavoriteRecipeDetail(savedRecipe: SavedRecipe?, router: Router) -> UIViewController
}

class AssemblyBuilderImplementation: AssemblyBuilder {
    func createRecipesList(router: Router) -> UIViewController {
        let view = RecipesListViewController()
        let networkManager = NetworkManagerImplementation()
        let presenter = RecipesListViewPresenter(view: view, networkManager: networkManager, router: router)
        view.presenter = presenter
        return view
    }
    
    func createRecipeDetail(recipe: Recipe?, router: Router) -> UIViewController {
        let view = RecipeDetailViewController()
        let storageManager = StorageManagerImplementation()
        let presenter = RecipeDetailPresenter(view: view, storageManager: storageManager, router: router, recipe: recipe)
        view.presenter = presenter
        return view
    }
    
    func createInstructions(recipe: Recipe?, router: Router) -> UIViewController {
        let view = InstructionsViewController()
        let presenter = InstructionsPresenter(view: view, recipe: recipe)
        view.presenter = presenter
        return view
    }
    
    func createFavoriteList(router: Router) -> UIViewController {
        let view = FavoriteListViewController()
        let storageManager = StorageManagerImplementation()
        let networkManager = NetworkManagerImplementation()
        let presenter = FavoriteListViewPresenter(view: view, storageManager: storageManager, networkManager: networkManager, router: router)
        view.presenter = presenter
        return view
    }
    
    func createFavoriteRecipeDetail(savedRecipe: SavedRecipe?, router: Router) -> UIViewController {
        let view = FavoriteRecipeDetailViewController()
        let storageManager = StorageManagerImplementation()
        let presenter = FavoriteRecipeDetailPresenter(view: view, storageManager: storageManager, router: router, savedRecipe: savedRecipe)
        view.presenter = presenter
        return view
    }
}
