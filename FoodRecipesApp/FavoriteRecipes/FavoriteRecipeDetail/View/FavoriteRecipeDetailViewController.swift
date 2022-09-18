//
//  FavoriteRecipeDetailViewController.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 18.09.2022.
//

import UIKit

class FavoriteRecipeDetailViewController: UIViewController {

    var presenter: FavoriteRecipeDetailOutput!
    private let cellIdentifier = "favoriteRecipeDetailCell"
    
    private lazy var tableview: UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableview.backgroundColor = .white
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.separatorStyle = .none
        return tableview
    }()
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = presenter.savedRecipe?.title
        tableview.dataSource = self
        tableview.delegate = self
        view.addSubview(tableview)
        setConstraints()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteRecipe))
    }
    
    //MARK: - private methods
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func deleteRecipe() {
        presenter.deleteRecipe()
    }
}

//MARK: - UITableViewDataSource
extension FavoriteRecipeDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 1
        if section == 0 {
            numberOfRows = presenter.savedRecipe?.ingredients.count ?? 0
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        if indexPath.section == 0 {
            content.text = presenter.savedRecipe?.ingredients[indexPath.row].ingredient
        } else {
            content.text = presenter.savedRecipe?.instruction
        }
        cell.contentConfiguration = content
        return cell
    }
}

//MARK: - UITableViewDelegate
extension FavoriteRecipeDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = RecipeDetailHeaderView()
        if section == 0 {
            headerView.label.text = "Ingredients"
            if let savedRecipe = presenter.savedRecipe {
                headerView.foodImageView.image = ImageCacheManager.shared.object(forKey: savedRecipe.title as NSString)
            }
        } else {
            headerView.label.text = "Instruction"
            headerView.foodImageView.image = nil
        }
        
        return headerView
        
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return  view.frame.height / 3
        }
        return 25
    }
}

//MARK: - RecipeDetailInput
extension FavoriteRecipeDetailViewController: FavoriteRecipeDetailInput {
    func setRecipe() {
        tableview.reloadData()
    }
}
