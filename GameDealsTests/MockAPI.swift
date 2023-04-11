// Description: Class to handle mock API calls
// Author:      Matthew Herrmann
// Project:     VideoGameDeals
// Date:        April 10, 2023

import Foundation
import GameDeals

class MockAPI: APIProtocol {
    
    // Return decoded items from location
    func fetchItems<T: Decodable>(location: String, parameters: [String : String]) async throws -> T {
        // Create path
        let bundle = Bundle(for: type(of: self))
        guard let path = bundle.url(forResource: location, withExtension: "json") else {
            throw APIError.invalidLocation
        }
        
        // Fetch and decode items
        do {
            let data = try Data(contentsOf: path)
            let items = try JSONDecoder().decode(T.self, from: data)
            return items
        } catch {
            throw APIError.invalidData
        }
    }
    
}
