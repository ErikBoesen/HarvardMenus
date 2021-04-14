import Foundation
import SwiftUI
import NavigationStack

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}

struct ItemPreviewView: View {
    let recipe: Recipe
    let allowed: Bool
    @EnvironmentObject private var navigationStack: NavigationStack

    init(recipe: Recipe, allowed: Bool) {
        self.recipe = recipe
        self.allowed = allowed
    }

    func getCourseImage() -> String {
//        if self.recipe.course == "Soup and Salad" {
//            if self.recipe.name.contains("Salad") {
//                return "custom_salad"
//            }
//            return "custom_soup"
//        }
//        if self.recipe.course == "Fruit and Yogurt" {
//            if self.recipe.name.contains("Yogurt") {
//                return "custom_yogurt"
//            }
//            return "custom_fruit"
//        }
//        return self.recipe.
        // TODO: implement
        return "Entree"
    }

    var body: some View {
        Button(action: {
            DispatchQueue.main.async {
                self.navigationStack.push(RecipeView(recipe: self.recipe))
            }
        }) {
            HStack {
                Image(self.getCourseImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 45, maxHeight: 45, alignment: .leading)
                    .padding(.trailing, 10)
                Spacer()
                Text(self.item.name)
                    .font(.appBody)
                    .foregroundColor(.main)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding()
            .background(Color.extraFaint)
            .cornerRadius(20)
        }
        .buttonStyle(PlainButtonStyle())
        .opacity(self.allowed ? 1 : 0.4)
    }
}

struct LocationView: View {
    @ObservedObject var model: LocationViewModel
    @State private var choosingDate = false
    @State private var chosenDate = Date()

    init(location: Location) {
        self.model = LocationViewModel(location: location)
    }

    func openDatePicker() {
        self.chosenDate = self.model.date
        self.choosingDate = true
    }

    func closeDatePicker() {
        self.model.date = self.chosenDate
        self.model.getMeals()
        self.choosingDate = false
    }

    var body: some View {
        VStack {
            Header(text: self.model.hall.nickname, hall: self.model.hall)
            if self.model.meals[self.model.date] != nil {
                if self.model.meals[self.model.date]!.isEmpty {
                    SplashView(image: self.model.hall.id, subtitle: "No menu posted.")
                } else {
                    SegmentedPicker(items: self.model.meals[self.model.date]!.map { $0.name }, selection: $model.mealIndex.onChange(onChange))
                        .padding(.bottom, 10)
                    Text("\(self.model.meals[self.model.date]![self.model.mealIndex].name) hours: \(self.model.reformatTime(self.model.meals[self.model.date]![self.model.mealIndex].startTime))-\(self.model.reformatTime(self.model.meals[self.model.date]![self.model.mealIndex].endTime))")
                        .font(.appBody)
                        .foregroundColor(.main)
                        .padding(.bottom, 4)
                    if self.model.items[self.model.date] != nil &&
                       self.model.items[self.model.date]![self.model.mealIndex] != nil &&
                       self.model.allowed[self.model.date]![self.model.mealIndex] != nil {
                        ScrollView {
                            VStack {
                                ForEach(
                                    Array(zip(
                                        self.model.items[self.model.date]![self.model.mealIndex]!,
                                        self.model.allowed[self.model.date]![self.model.mealIndex]!
                                    )),
                                    id: \.0.id
                                ) { item, allowed in
                                    ItemPreviewView(item: item, allowed: allowed)
                                }
                            }
                        }
                    } else {
                        Loader()
                    }
                }
            } else {
                Loader()
            }
            HStack {
                Button(action: {
                    self.model.changeDay(by: -1)
                }) {
                    Image(systemName: "chevron.left.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 25)
                        .foregroundColor(.medium)
                }.buttonStyle(PlainButtonStyle())
                Spacer()
                if self.choosingDate {
                    Button(action: { self.closeDatePicker() }) {
                        Text("Done")
                            .font(.appBodyMedium)
                            .foregroundColor(.main)
                    }.buttonStyle(PlainButtonStyle())
                } else {
                    Button(action: { self.openDatePicker() }) {
                        HStack {
                            Image(systemName: "calendar")
                                .frame(width: 25)
                                .foregroundColor(.main)
                            Text(self.model.dateFormatterExternal.string(from: self.model.date))
                                .font(.appBodyMedium)
                                .foregroundColor(.main)
                        }
                    }.frame(maxWidth: .infinity)
                }
                Spacer()
                Button(action: {
                    self.model.changeDay(by: 1)
                }) {
                    Image(systemName: "chevron.right.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 25)
                        .foregroundColor(.medium)
                }.buttonStyle(PlainButtonStyle())
            }
            .padding(.top, 5)
            .frame(maxWidth: .infinity)
            if self.choosingDate {
                // TODO: use foreground color
                DatePicker(
                    "",
                    selection: $chosenDate,
                    displayedComponents: .date
                )
                .labelsHidden()
                // TODO: use this once iOS 14 is more widespread!
                //.datePickerStyle(GraphicalDatePickerStyle())
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .padding()
    }

    func onChange(mealIndex: Int) {
        self.model.mealIndex = mealIndex
        self.model.getItems(date: self.model.date, mealIndex: mealIndex)
    }
}
