//
//  FavoriteListViewController.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 15.09.2022.
//

import UIKit

class FavoriteListViewController: UIViewController {

    var presenter: FavoriteListViewPresenter!
    private let cellIdentifier = "recipeCell"
    private let tabBarIt = UITabBarItem(title: "Favorite Recipes", image: UIImage(systemName: "heart"), tag: 1)
    
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
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        tabBarItem = tabBarIt
        setupNavigationBar()
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        setConstraints()
    }
    
    //MARK: - private methods
    private func setupNavigationBar() {
        title = "Favorite Recipes"
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
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - UICollectionViewDelegate
extension FavoriteListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recipe = presenter?.recipes?[indexPath.item]
        presenter.tapOnRecipe(recipe: recipe)
    }
}

//MARK: - UICollectionViewDataSource
extension FavoriteListViewController: UICollectionViewDataSource {
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
extension FavoriteListViewController: FavoriteListInput {
    func getRecipes() {
        collectionView.reloadData()
    }
}
