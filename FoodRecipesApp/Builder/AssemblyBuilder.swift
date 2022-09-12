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
        let networkManager = NetworkManagerImplementation()
        let presenter = RecipeDetailPresenter(view: view, networkManager: networkManager, router: router, recipe: recipe)
        view.presenter = presenter
        return view
    }
    
    func createInstructions(recipe: Recipe?, router: Router) -> UIViewController {
        let view = InstructionsViewController()
        let networkManager = NetworkManagerImplementation()
        let presenter = InstructionsPresenter(view: view, networkManager: networkManager, router: router, recipe: recipe)
        view.presenter = presenter
        return view
    }
}
