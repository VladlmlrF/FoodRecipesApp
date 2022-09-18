//
//  NetworkManager.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 09.09.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

protocol NetworkManager: AnyObject {
    func fetchData(_ completion: @escaping(Result<FoodRecipes, NetworkError>) -> ())
    func fetchImageData(urlString: String, _ completion: @escaping(Result<Data, NetworkError>) -> ())
}

class NetworkManagerImplementation: NetworkManager {
    
    func fetchData(_ completion: @escaping(Result<FoodRecipes, NetworkError>) -> ()) {
        guard let url = URL(string: "https://api.spoonacular.com/recipes/random?number=25&apiKey=8badfaa24f6a43f4998718a795e6a40a") else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let foodRecipes = try JSONDecoder().decode(FoodRecipes.self, from: data)
                completion(.success(foodRecipes))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImageData(urlString: String, _ completion: @escaping(Result<Data, NetworkError>) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        do {
            let imageData = try Data(contentsOf: url)
            completion(.success(imageData))
        } catch {
            completion(.failure(.noData))
        }
    }
}
