//
//  Router.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 10.09.2022.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilder? { get set }
}

protocol Router: RouterMain {
    func initialViewController()
    func showFavoriteRecipeList()
    func showDetail(recipe: Recipe?)
    func showInstructions(recipe: Recipe?)
    func showFavoriteDetail(savedRecipe: SavedRecipe?)
    func back()
}

class RouterImplementation: Router {
    weak var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilder?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilder) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let recipesListVC = assemblyBuilder?.createRecipesList(router: self) else { return }
            navigationController.viewControllers = [recipesListVC]
        }
    }
    
    func showFavoriteRecipeList() {
        if let navigationController = navigationController {
            guard let favoriteListVC = assemblyBuilder?.createFavoriteList(router: self) else { return }
            navigationController.viewControllers = [favoriteListVC]
        }
    }
    
    func showDetail(recipe: Recipe?) {
        guard let recipeDetailVC = assemblyBuilder?.createRecipeDetail(recipe: recipe, router: self) else { return }
        navigationController?.pushViewController(recipeDetailVC, animated: true)
    }
    
    func showInstructions(recipe: Recipe?) {
        guard let instructionsVC = assemblyBuilder?.createInstructions(recipe: recipe, router: self) else { return }
        navigationController?.present(instructionsVC, animated: true)
    }
    
    func showFavoriteDetail(savedRecipe: SavedRecipe?) {
        guard let favoriteRecipeDetailVC = assemblyBuilder?.createFavoriteRecipeDetail(savedRecipe: savedRecipe, router: self) else { return }
        navigationController?.pushViewController(favoriteRecipeDetailVC, animated: true)
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
}
