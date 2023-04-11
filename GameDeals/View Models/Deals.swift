// Description: Class to hold Cheap Shark deals
// Author:      Matthew Herrmann
// Project:     VideoGameDeals
// Date:        April 10, 2023

import Foundation

@MainActor
class Deals: ObservableObject {
    
    static let domain = "https://www.cheapshark.com/"
    private let api: APIProtocol
    private let location: String
    @Published var contents = [Deal]()
    
    init(api: APIProtocol = API(), location: String = "\(Deals.domain)api/1.0/deals") {
        self.api = api
        self.location = location
    }
    
    // Fetch contents from Cheap Shark [Deal]
    func fetch(page: Int = 0, search: String = "", exact: Bool = false, refresh: Bool = false) async {
        // Create filters
        var filters: [String : String] = [:]
        filters["pageNumber"] = String(page)
        filters["title"] = "\(search.replacingOccurrences(of: " ", with: "%20"))"
        filters["exact"] = exact ? "1" : "0"
        
        // Fetch contents array
        do {
            let deals: [Deal] = try await api.fetchItems(location: location, parameters: filters)
            if (refresh) {
                contents = []
            }
            contents += deals
        } catch {
            print(error)
        }
    }
    
}
