//
//  RecipeDetailFooterView.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 11.09.2022.
//

import UIKit

class RecipeDetailFooterView: UIView {
    lazy var instructionsButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Get instructions", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = .orange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(instructionsButton)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            instructionsButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            instructionsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            instructionsButton.heightAnchor.constraint(equalToConstant: 50),
            instructionsButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
        ])
    }
}
