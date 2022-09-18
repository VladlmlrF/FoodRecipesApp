//
//  InstructionsPresenter.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 12.09.2022.
//

import Foundation

//MARK: - Instructions input protocol
protocol InstructionsInput: AnyObject {
    func setInstructions(_ instruction: String)
}

//MARK: - Instructions output protocol
protocol InstructionsOutput: AnyObject {
    var recipe: Recipe? { get set }
    init(view: InstructionsInput, recipe: Recipe?)
    func setInstructions()
}

//MARK: - InstructionsOutput
class InstructionsPresenter: InstructionsOutput {
    weak var view: InstructionsInput!
    var recipe: Recipe?
    
    required init(view: InstructionsInput, recipe: Recipe?) {
        self.view = view
        self.recipe = recipe
        setInstructions()
    }
    
    func setInstructions() {
        if let instruction = recipe?.instructions {
            view.setInstructions(instruction)
        }
    }
}
