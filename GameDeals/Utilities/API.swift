// Description: Class to handle generic API calls
// Author:      Matthew Herrmann
// Project:     GameDeals
// Date:        April 10, 2023

import Foundation

public enum APIError: Error {
    case invalidLocation, invalidData
}

public protocol APIProtocol {
    func fetchItems<T: Decodable>(location: String, parameters: [String : String]) async throws -> T
}

class API: APIProtocol {
    
    // Return decoded items from location
    func fetchItems<T: Decodable>(location: String, parameters: [String : String]) async throws -> T {
        // Unpack parameters
        var params = "?"
        for (key, value) in parameters {
            params += "\(key)=\(value)&"
        }
        params = String(params.dropLast())
        
        // Create url
        let urlString = "\(location)\(params)"
        guard let url = URL(string: urlString) else {
            throw APIError.invalidLocation
        }
        
        // Fetch and decode items
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(T.self, from: data)
            return items
        } catch {
            throw APIError.invalidData
        }
    }
    
}
