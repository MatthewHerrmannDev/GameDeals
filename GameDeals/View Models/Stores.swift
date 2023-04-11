// Description: Class to hold Cheap Shark stores
// Author:      Matthew Herrmann
// Project:     VideoGameDeals
// Date:        April 10, 2023

import Foundation

@MainActor
class Stores: ObservableObject {
    
    static let domain = "https://www.cheapshark.com/"
    private let api: APIProtocol
    private let location: String
    @Published var contents = [String : Store]()
    
    init(api: APIProtocol = API(), location: String = "\(Stores.domain)api/1.0/stores") {
        self.api = api
        self.location = location
    }
    
    // Fetch stores from Cheap Shark [storeID : store]
    func fetch() async {
        do {
            let stores: [Store] = try await api.fetchItems(location: location, parameters: [:])
            var newContents: [String : Store] = [:]
            for store in stores {
                newContents[store.storeID] = store
            }
            contents = newContents
        } catch {
            print(error)
        }
    }
    
}
