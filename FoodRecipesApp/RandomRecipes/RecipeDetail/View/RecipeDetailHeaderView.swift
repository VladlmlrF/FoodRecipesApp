//
//  RecipeDetailHeaderView.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 11.09.2022.
//

import UIKit

class RecipeDetailHeaderView: UIView {

    lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var ingredientsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ingredients"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "unselectedHeart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(foodImageView)
        addSubview(ingredientsLabel)
        foodImageView.addSubview(favoriteButton)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: self.topAnchor),
            foodImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            foodImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            foodImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -35),
            
            ingredientsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            ingredientsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            ingredientsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            
            favoriteButton.topAnchor.constraint(equalTo: foodImageView.topAnchor, constant: 20),
            favoriteButton.trailingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: -20)
        ])
    }
    
}
