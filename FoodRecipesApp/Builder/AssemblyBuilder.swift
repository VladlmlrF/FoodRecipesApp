//
//  AssemblyBuilder.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 10.09.2022.
//

import UIKit

protocol AssemblyBuilder {
    func createRecipesList(router: Router) -> UIViewController
}

class AssemblyBuilderImplementation: AssemblyBuilder {
    func createRecipesList(router: Router) -> UIViewController {
        let view = RecipesListViewController()
        let networkManager = NetworkManagerImplementation()
        let presenter = RecipesListViewPresenter(view: view, networkManager: networkManager)
        view.presenter = presenter
        return view
    } 
}
