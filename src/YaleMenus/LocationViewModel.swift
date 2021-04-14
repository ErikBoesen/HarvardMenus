import Foundation

class LocationViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let nm = NetworkManager()
    let settings = Settings()

    @Published var location: Location
    @Published var meals: [Date: [Menu]] = [:]
    @Published var mealNames: [String]?
    @Published var mealIndex: Int = 0
    @Published var recipes: [Date: [[Recipe]?]] = [:]
    @Published var allowed: [Date: [[Bool]?]] = [:]
    @Published var date: Date = Date()
    public let dateFormatterInternal = DateFormatter()
    public let dateFormatterExternal = DateFormatter()
    public let timeFormatterInternal = DateFormatter()
    public let timeFormatterExternal = DateFormatter()

    init(location: Location) {
        self.location = location
        self.dateFormatterInternal.dateFormat = "yyyy-MM-dd"
        self.dateFormatterExternal.dateFormat = "MMMM d"
        self.timeFormatterInternal.dateFormat = "HH:mm"
        self.timeFormatterExternal.dateFormat = DateFormatter.dateFormat(fromTemplate: "j:mm", options: 0, locale: Locale.current)?.replacingOccurrences(of: " ", with: "")
        // For testing while we don't have updated data.
        //self.date = self.formatterInternal.date(from: "2020-09-24")!
        self.getMeals()
    }

    func getPresentMeal() -> Int {
        // TODO: reenable
//        let today = Date()
//        if Calendar.current.isDate(self.date, inSameDayAs: today) {
//            let now = self.timeFormatterInternal.string(from: today)
//            for (index, meal) in self.meals[self.date]!.enumerated() {
//                if now < meal.endTime {
//                    return index
//                }
//            }
//        }
        return 0
    }

    func getMeals() {
        let date = self.date
        if self.meals[date] == nil {
            // TODO: reenable
//            nm.getMeals(hallId: self.hall.id,
//                        date: self.dateFormatterInternal.string(from: date),
//                        completion: { meals in
//                self.meals[date] = meals
//                if self.recipes[date] == nil {
//                    self.recipes[date] = [[Recipe]?](repeating: nil, count: meals.count)
//                    self.allowed[date] = [[Bool]?](repeating: nil, count: meals.count)
//                    self.mealIndex = self.getPresentMeal()
//                    // TODO: switch to whatever current/soonest meal is
//                    self.getRecipes(date: date, mealIndex: self.mealIndex)
//                }
//            })
        }
    }

    func getRecipes(date: Date, mealIndex: Int) {
        if (self.meals[date] != nil &&
            self.recipes[date] != nil &&
            mealIndex < self.recipes[date]!.count &&
            self.recipes[date]![mealIndex] == nil) {
            // TODO: reenable
//            nm.getRecipes(mealId: self.meals[date]![mealIndex].id, completion: { recipes in
//                self.allowed[date]![mealIndex] = recipes.map { recipe in
//                    !(
//                        (self.settings.meat && recipe.meat) ||
//                        (self.settings.animalProducts && recipe.animalProducts) ||
//                        (self.settings.alcohol && recipe.alcohol) ||
//                        (self.settings.treeNut && recipe.treeNut) ||
//                        (self.settings.shellfish && recipe.shellfish) ||
//                        (self.settings.peanuts && recipe.peanuts) ||
//                        (self.settings.dairy && recipe.dairy) ||
//                        (self.settings.egg && recipe.egg) ||
//                        (self.settings.pork && recipe.pork) ||
//                        (self.settings.fish && recipe.fish) ||
//                        (self.settings.soy && recipe.soy) ||
//                        (self.settings.wheat && recipe.wheat) ||
//                        (self.settings.gluten && recipe.gluten) ||
//                        (self.settings.coconut && recipe.coconut) ||
//                        (self.settings.alcohol && recipe.alcohol)
//                    )
//                }
//                self.recipes[date]![mealIndex] = recipes
//            })
        }
    }

    func changeDay(by: Int) {
        self.date = Calendar.current.date(byAdding: .day, value: by, to: self.date)!
        self.getMeals()
    }

    func reformatTime(_ time: String) -> String {
        let read = self.timeFormatterInternal.date(from: time)!
        // TODO: can we lowercase am/pm within the format string?
        return self.timeFormatterExternal.string(from: read).lowercased()
    }
}
