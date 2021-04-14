import Foundation

class HallsViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let nm = NetworkManager()

    @Published var showAlert: Bool = false
    @Published var alertMessage: String?
    @Published var halls: [Location]?

    func load() {
        nm.getLocations(completion: { locations in
            self.halls = locations
        })
    }

    init() {
        load()
    }
}
