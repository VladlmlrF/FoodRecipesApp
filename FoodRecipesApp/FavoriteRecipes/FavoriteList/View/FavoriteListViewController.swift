//
//  FavoriteListViewController.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 15.09.2022.
//

import UIKit
//import RealmSwift

class FavoriteListViewController: UIViewController {
    
    var presenter: FavoriteListViewPresenter!
    private let cellIdentifier = "savedRecipeCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: UIScreen.main.bounds.height / 3)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(SavedRecipeCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupNavigationBar()
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
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
//        let recipe = presenter?.recipes?[indexPath.item]
//        presenter.tapOnRecipe(recipe: recipe)
    }
}

//MARK: - UICollectionViewDataSource
extension FavoriteListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? SavedRecipeCell else { return UICollectionViewCell() }
        guard let savedRecipeList = presenter.savedRecipeList else { return UICollectionViewCell() }
        let savedRecipe = savedRecipeList[indexPath.item]
        cell.nameLabel.text = savedRecipe.title
        if let cachedImage = ImageCacheManager.shared.object(forKey: savedRecipe.title as NSString) {
            cell.imageView.image = cachedImage
        } else {
            presenter.fetchImage(savedRecipe: savedRecipe) { data in
                cell.imageView.image = UIImage(data: data)
                if let image = UIImage(data: data) {
                    ImageCacheManager.shared.setObject(image, forKey: savedRecipe.title as NSString)
                }
            }
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
