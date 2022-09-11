//
//  RecipeDetailViewController.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 11.09.2022.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var presenter: RecipeDetailOutput!
    private let cellIdentifier = "recipeDetailCell"
    
    private lazy var tableview: UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableview.backgroundColor = .white
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.separatorStyle = .none
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = presenter.recipe?.title
        tableview.dataSource = self
        tableview.delegate = self
        view.addSubview(tableview)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension RecipeDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.recipe?.extendedIngredients.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = presenter.recipe?.extendedIngredients[indexPath.row].original
        cell.contentConfiguration = content
        return cell
    }
}

extension RecipeDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = RecipeDetailHeaderView()
        if let imageData = presenter.imageData {
            headerView.foodImageView.image = UIImage(data: imageData)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = RecipeDetailFooterView()
        return footerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        view.frame.height / 3
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        60
    }
}

extension RecipeDetailViewController: RecipeDetailInput {
    func setRecipe() {
        tableview.reloadData()
    }
}
