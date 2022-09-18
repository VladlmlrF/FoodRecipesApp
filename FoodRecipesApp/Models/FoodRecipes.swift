//
//  FoodRecipes.swift
//  FoodRecipesApp
//
//  Created by Владимир Фалин on 09.09.2022.
//

struct FoodRecipes: Decodable {
    let recipes: [Recipe]
}

struct Recipe: Decodable {
    let vegetarian: Bool
    let vegan: Bool
    let glutenFree: Bool
    let dairyFree: Bool
    let veryHealthy: Bool
    let cheap: Bool
    let veryPopular: Bool
    let sustainable: Bool
    let lowFodmap: Bool
    let weightWatcherSmartPoints: Int
    let gaps: String
    let preparationMinutes: Int
    let cookingMinutes: Int
    let aggregateLikes: Int
    let healthScore: Int
    let creditsText: String?
    let license: String?
    let sourceName: String?
    let pricePerServing: Double
    let extendedIngredients: [ExtendedIngredient]
    let id: Int
    let title: String
    let readyInMinutes: Int
    let servings: Int
    let sourceUrl: String
    let image: String?
    let imageType: String?
    let summary: String
    let cuisines: [String]
    let dishTypes: [String]
    let diets: [String]
    let occasions: [String]
    let instructions: String
    let analyzedInstructions: [AnalyzedInstruction]
    let originalId: Int?
    let spoonacularSourceUrl: String
}

struct ExtendedIngredient: Decodable {
    let id: Int
    let aisle: String?
    let image: String?
    let consistency: String
    let name: String
    let nameClean: String?
    let original: String
    let originalName: String
    let amount: Double
    let unit: String
    let meta: [String]
    let measures: Measures
}

struct Measures: Decodable {
    let us: Us
    let metric: Metric
}

struct Us: Decodable {
    let amount: Double
    let unitShort: String
    let unitLong: String
}

struct Metric: Decodable {
    let amount: Double
    let unitShort: String
    let unitLong: String
}

struct AnalyzedInstruction: Decodable {
    let name: String
    let steps: [Step]
}

struct Step: Decodable {
    let number: Int
    let step: String
    let ingredients: [Ingredient]
    let equipment: [Equipment]
    let length: Length?
}

struct Ingredient: Decodable {
    let id: Int
    let name: String
    let localizedName: String
    let image: String
    let temperature: Length?
}

struct Equipment: Decodable {
    let id: Int
    let name: String
    let localizedName: String
    let image: String
    let temperature: Length?
}

struct Length: Decodable {
    let number: Int
    let unit: String
}


//// MARK: - FoodRecipes
//struct FoodRecipes: Codable {
//    let recipes: [Recipe]
//}
//
//// MARK: - Recipe
//struct Recipe: Codable {
//    let vegetarian, vegan, glutenFree, dairyFree: Bool
//    let veryHealthy, cheap, veryPopular, sustainable: Bool
//    let lowFodmap: Bool
//    let weightWatcherSmartPoints: Int
//    let gaps: Gaps
//    let preparationMinutes, cookingMinutes, aggregateLikes, healthScore: Int
//    let creditsText: String?
//    let license: String?
//    let sourceName: String?
//    let pricePerServing: Double
//    let extendedIngredients: [ExtendedIngredient]
//    let id: Int
//    let title: String
//    let readyInMinutes, servings: Int
//    let sourceURL: String
//    let image: String
//    let imageType: ImageType
//    let summary: String
//    let cuisines, dishTypes, diets, occasions: [String]
//    let instructions: String
//    let analyzedInstructions: [AnalyzedInstruction]
//    let originalID: JSONNull?
//    let spoonacularSourceURL: String
//
//    enum CodingKeys: String, CodingKey {
//        case vegetarian, vegan, glutenFree, dairyFree, veryHealthy, cheap, veryPopular, sustainable, lowFodmap, weightWatcherSmartPoints, gaps, preparationMinutes, cookingMinutes, aggregateLikes, healthScore, creditsText, license, sourceName, pricePerServing, extendedIngredients, id, title, readyInMinutes, servings
//        case sourceURL = "sourceUrl"
//        case image, imageType, summary, cuisines, dishTypes, diets, occasions, instructions, analyzedInstructions
//        case originalID = "originalId"
//        case spoonacularSourceURL = "spoonacularSourceUrl"
//    }
//}
//
//// MARK: - AnalyzedInstruction
//struct AnalyzedInstruction: Codable {
//    let name: Name
//    let steps: [Step]
//}
//
//enum Name: String, Codable {
//    case empty = ""
//    case wholeWheatPizzaDoughInstructions = "Whole Wheat Pizza Dough Instructions"
//}
//
//// MARK: - Step
//struct Step: Codable {
//    let number: Int
//    let step: String
//    let ingredients, equipment: [Ent]
//    let length: Length?
//}
//
//// MARK: - Ent
//struct Ent: Codable {
//    let id: Int
//    let name, localizedName, image: String
//    let temperature: Length?
//}
//
//// MARK: - Length
//struct Length: Codable {
//    let number: Int
//    let unit: Unit
//}
//
//enum Unit: String, Codable {
//    case fahrenheit = "Fahrenheit"
//    case minutes = "minutes"
//}
//
//// MARK: - ExtendedIngredient
//struct ExtendedIngredient: Codable {
//    let id: Int
//    let aisle: String
//    let image: String?
//    let consistency: Consistency
//    let name: String
//    let nameClean: String?
//    let original, originalName: String
//    let amount: Double
//    let unit: String
//    let meta: [String]
//    let measures: Measures
//}
//
//enum Consistency: String, Codable {
//    case liquid = "LIQUID"
//    case solid = "SOLID"
//}
//
//// MARK: - Measures
//struct Measures: Codable {
//    let us, metric: Metric
//}
//
//// MARK: - Metric
//struct Metric: Codable {
//    let amount: Double
//    let unitShort, unitLong: String
//}
//
//enum Gaps: String, Codable {
//    case no = "no"
//}
//
//enum ImageType: String, Codable {
//    case jpg = "jpg"
//}
//
//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
