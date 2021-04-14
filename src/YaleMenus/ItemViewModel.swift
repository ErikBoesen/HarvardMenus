import Foundation

class RecipeViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let nm = NetworkManager()
    let settings = Settings()

    @Published var recipe: Recipe
    @Published var nutrition: Nutrition?

    init(recipe: Recipe, defaults: UserDefaults = .standard) {
        self.recipe = recipe
        if self.settings.showNutrition {
//            nm.getNutrition(recipeId: self.recipe.id, completion: { nutrition in
//                self.nutrition = nutrition
//            })
        }
    }
}
