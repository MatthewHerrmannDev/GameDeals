// Description: Struct for decoding a Cheap Shark store
// Author:      Matthew Herrmann
// Project:     VideoGameDeals
// Date:        April 10, 2023

import Foundation

struct Store: Codable, Hashable {
    
    struct Images: Codable, Hashable {
        private let logo: String
        private let icon: String
        
        var logoURL: URL? { URL(string: "\(Stores.domain)\(logo)") }
        var iconURL: URL? { URL(string: "\(Stores.domain)\(icon)") }
    }
    
    let storeID: String
    let storeName: String
    let images: Images
    
}
