import Foundation
import Moya

enum API {
    case status
    case halls
    case hall(id: String)
    case managers(hallId: String)
    case meals(hallId: String, date: String)
    case meal(id: Int)
    case items(mealId: Int)
    case item(id: Int)
    case nutrition(itemId: Int)
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
        case .menus(let _, let _, let _):
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
        case .menus(let date, let meal, let location):
            return .requestParameters(parameters: [
                "date": date,
                "meal": meal,
                "location": location
            ], encoding: URLEncoding.queryString)
        default:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return nil
    }
}
