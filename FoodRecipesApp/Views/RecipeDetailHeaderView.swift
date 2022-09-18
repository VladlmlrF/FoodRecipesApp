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
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(foodImageView)
        addSubview(label)
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
            
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
    
}
