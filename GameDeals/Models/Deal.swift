// Description: Deal struct for a decoding Cheap Shark deal
// Author:      Matthew Herrmann
// Project:     GameDeals
// Date:        April 10, 2023

import Foundation

struct Deal: Codable, Hashable, Identifiable {
    
    let id = UUID()
    let title: String
    let dealID: String
    let storeID: String
    let salePrice: String
    let normalPrice: String
    let isOnSale: String
    private let thumb: String
    
    var thumbURL: URL? { URL(string: thumb) }
    var dealURL: String { "\(Deals.domain)redirect?dealID=\(dealID)" }
    
}
