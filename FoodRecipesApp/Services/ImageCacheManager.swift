//
//  ImageCacheManager.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 17.09.2022.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
