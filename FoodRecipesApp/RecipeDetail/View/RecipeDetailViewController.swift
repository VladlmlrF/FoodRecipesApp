//
//  RecipeDetailViewController.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 11.09.2022.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var presenter: RecipeDetailOutput!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
}

extension RecipeDetailViewController: RecipeDetailInput {
    func setRecipe(recipe: Recipe?) {
        
    }
}
