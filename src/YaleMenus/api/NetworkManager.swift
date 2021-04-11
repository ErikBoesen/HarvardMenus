import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<API> { get }

    func getCategories(completion: @escaping ([Category]) -> Void)
    func getCategory(id: Int, completion: @escaping (Category) -> Void)
    func getLocations(completion: @escaping ([Location]) -> Void)
    func getLocation(id: String, completion: @escaping (Location) -> Void)
    func getMenus(date: String, mealId: Int, locationId: Int, completion: @escaping ([Menu]) -> Void)
    func getRecipes(mealId: Int, completion: @escaping ([Recipe]) -> Void)
    func getRecipe(itemId: Int, completion: @escaping (Recipe) -> Void)
}

struct NetworkManager {
    fileprivate let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])

    func getCategories(completion: @escaping ([Category]) -> Void) {
        provider.request(.categories) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([Category].self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getCategory(id: String, completion: @escaping (Category) -> Void) {
        provider.request(.category(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Category.self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getLocations(completion: @escaping ([Location]) -> Void) {
        provider.request(.locations) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([Location].self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getLocation(id: Int, date: String, completion: @escaping (Location) -> Void) {
        provider.request(.location(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Location.self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getMenus(date: String, mealId: Int, locationId: Int, completion: @escaping ([Menu]) -> Void) {
        provider.request(.menus(date: date, mealId: mealId, locationId: locationId)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([Menu].self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getRecipes(completion: @escaping ([Recipe]) -> Void) {
        provider.request(.recipes) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode([Recipe].self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    func getRecipe(id: Int, completion: @escaping (Recipe) -> Void) {
        provider.request(.recipe(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Recipe.self, from: response.data)
                    completion(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
