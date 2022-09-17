//
//  RecipesListViewController.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 09.09.2022.
//

import UIKit

class RecipesListViewController: UIViewController {

    var presenter: RecipesListOutput!
    private let cellIdentifier = "recipeCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 3)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(RecipeCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        return activity
    }()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupNavigationBar()
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        setConstraints()
        activityIndicator.startAnimating()
    }
    
    //MARK: - private methods
    private func setupNavigationBar() {
        title = "Food Recipes"
        navigationController?.navigationBar.prefersLargeTitles = true
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

//MARK: - UICollectionViewDelegate
extension RecipesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = presenter?.recipes?[indexPath.item]
        presenter.tapOnRecipe(recipe: recipe)
    }
}

//MARK: - UICollectionViewDataSource
extension RecipesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? RecipeCell else { return UICollectionViewCell() }
        let recipe = presenter.recipes?[indexPath.item]
        cell.nameLabel.text = recipe?.title
        cell.ingredientsCountLabel.text = "\(recipe?.extendedIngredients.count ?? 0) ingredients"
        if let imageData = presenter.imageData {
            cell.imageView.image = imageData.indices.contains(indexPath.item) ? UIImage(data: imageData[indexPath.item]) : UIImage(named: "noImage")
        }
        
        return cell
    }
}

//MARK: - RecipesListInput
extension RecipesListViewController: RecipesListInput {
    func getRecipes() {
        activityIndicator.stopAnimating()
        collectionView.reloadData()
    }
}
