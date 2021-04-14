import Foundation

class HomeViewModel: ObservableObject, Identifiable {
    let id = UUID()
    let nm = NetworkManager()

    @Published var showAlert: Bool = false
    @Published var alertMessage: String?
    @Published var locations: [Location]?

    func load() {
        nm.getLocations(completion: { locations in
            self.locations = locations
        })
    }

    init() {
        load()
    }
}
