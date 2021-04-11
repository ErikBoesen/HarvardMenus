import Foundation
import Moya

enum API {
    case categories
    case category(id: String)
    case locations
    case location(id: Int)
    case menus(date: String, mealId: Int, locationId: Int)
    case recipes
    case recipe(id: Int)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.cs50.io/dining/")!
    }

    var path: String {
        switch self {
        case .categories:
            return "categories"
        case .category(let id):
            return "categories/\(id)"
        case .locations:
            return "locations"
        case .location(let id):
            return "locations/\(id)"
        case .menus(_, _, _):
            return "menus"
        case .recipes:
            return "recipes"
        case .recipe(let id):
            return "recipies/\(id)"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .menus(let date, let mealId, let locationId):
            return .requestParameters(parameters: [
                "date": date,
                "meal": mealId,
                "location": locationId
            ], encoding: URLEncoding.queryString)
        default:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
