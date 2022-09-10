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
}

class RouterImplementation: Router {
    var navigationController: UINavigationController?
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
}
