import Foundation

struct Category: Identifiable {
    let id: Int
    let name: String
}

extension Category: Decodable {
    enum CategoryCodingKeys: String, CodingKey {
        case id
        case name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoryCodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}

struct Location {
    let id: Int
    let name: String
}

extension Location: Decodable {
    enum LocationCodingKeys: String, CodingKey {
        case id
        case name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LocationCodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}

struct Menu {
    let categoryId: Int
    let date: String
    let locationIds: [Int]
    let mealId: Int
    let recipeId: Int
}

extension Menu: Decodable {
    enum MenuCodingKeys: String, CodingKey {
        case categoryId = "category"
        case date
        case locationIds = "location"
        case mealId = "meal"
        case recipeId = "recipe"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MenuCodingKeys.self)

        categoryId = try container.decode(Int.self, forKey: .categoryId)
        date = try container.decode(String.self, forKey: .date)
        locationIds = try container.decode([Int].self, forKey: .locationIds)
        mealId = try container.decode(Int.self, forKey: .categoryId)
        recipeId = try container.decode(Int.self, forKey: .recipeId)
    }
}

struct Nutrient {
    let amount: String
    let percent: Int?
}

extension Nutrient: Decodable {
    enum NutrientCodingKeys: String, CodingKey {
        case amount
        case percent
    }
    
    init(from decoder: Decoder) {
        let container = try decoder.container(keyedBy: NutrientCodingKeys.self)
        
        amount = try container.decode(String.self, forKey: .amount)
        percent = try container.decode(Int?.self, forKey: .percent)
    }
}

struct Recipe {
    let id: Int
    let name: String
    let information: String?
    let ingredients: String
    let allergens: [String]
    let servingSize: String
    let calories: Int
    let caloriesFromFat: Int
    let totalFat: Nutrient
    let satFat: Nutrient
    let transFat: Nutrient
    let cholesterol: Nutrient
    let sodium: Nutrient
    let totalCarb: Nutrient
    let dietaryFiber: Nutrient
    let sugars: Nutrient
    let protein: Nutrient
    let vegetarian: Bool
    let vegan: Bool
}

extension Recipe: Decodable {
    enum RecipeCodingKeys: String, CodingKey {
        case id
        case name
        case information
        case ingredients
        case allergens
        case servingSize = "serving_size"
        case calories
        case caloriesFromFat = "calories_from_fat"
        case totalFat = "total_fat"
        case satFat = "sat_fat"
        case transFat = "trans_fat"
        case cholesterol
        case sodium
        case totalCarb = "total_carb"
        case dietaryFiber = "dietary_fiber"
        case sugars
        case protein
        case vegetarian
        case vegan
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RecipeCodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        information = try container.decode(String?.self, forKey: .information)
        ingredients = try container.decode(String.self, forKey: .ingredients)
        allergens = try container.decode([String].self, forKey: .allergens)
        servingSize = try container.decode(String.self, forKey: .servingSize)
        calories = try container.decode(Int.self, forKey: .calories)
        caloriesFromFat = try container.decode(Int.self, forKey: .caloriesFromFat)
        totalFat = try container.decode(Nutrient.self, forKey: .totalFat)
        satFat = try container.decode(Nutrient.self, forKey: .satFat)
        transFat = try container.decode(Nutrient.self, forKey: .transFat)
        cholesterol = try container.decode(Nutrient.self, forKey: .cholesterol)
        sodium = try container.decode(Nutrient.self, forKey: .sodium)
        totalCarb = try container.decode(Nutrient.self, forKey: .totalCarb)
        dietaryFiber = try container.decode(Nutrient.self, forKey: .dietaryFiber)
        sugars = try container.decode(Nutrient.self, forKey: .sugars)
        protein = try container.decode(Nutrient.self, forKey: .protein)
        vegetarian = try container.decode(Bool.self, forKey: .vegetarian)
        vegan = try container.decode(Bool.self, forKey: .vegan)
    }
}

struct Nutrition {

    let totalFatPDV: Int
    let saturatedFatPDV: Int
    let transFatPDV: Int?
    let cholesterolPDV: Int
    let sodiumPDV: Int
    let totalCarbohydratePDV: Int
    let dietaryFiberPDV: Int
    let totalSugarsPDV: Int?
    let proteinPDV: Int
    let vitaminDPDV: Int
    let vitaminAPDV: Int
    let vitaminCPDV: Int
    let calciumPDV: Int
    let ironPDV: Int
    let potassiumPDV: Int

    let itemId: Int
}
