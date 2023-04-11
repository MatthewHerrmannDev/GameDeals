// Description: Info and link to deal from Cheap Shark
// Author:      Matthew Herrmann
// Project:     GameDeals
// Date:        April 10, 2023

import SwiftUI
import SDWebImageSwiftUI

struct DealListing: View {
    
    @EnvironmentObject var stores: Stores
    let deal: Deal
    let width: Double
    let scale: Double
    
    var body: some View {
        HStack {
            storeLogo
            VStack(spacing: 0) {
                storeName
                price
                link
            }
        }
        .padding([.top, .bottom], width * scale / 2)
    }
    
    // Square Logo of Store
    var storeLogo: some View {
        WebImage(url: stores.contents[deal.storeID]!.images.logoURL)
            .placeholder { Color.textSecondary }
            .resizable()
            .scaledToFill()
            .frame(width: width / 5, height: width / 5)
            .padding(.trailing, width * scale / 2)
    }
    
    // Name of store
    var storeName: some View {
        HStack {
            Text(stores.contents[deal.storeID]!.storeName)
                .foregroundColor(Color.textPrimary)
                .font(.system(size: width * scale, weight: .semibold))
            Spacer()
        }
    }
    
    // Deal price
    var price: some View {
        HStack {
            if (deal.isOnSale == "1") {
                Text("$\(deal.normalPrice) ")
                    .strikethrough()
            }
            Text("$\(deal.salePrice)")
            Spacer()
        }
        .foregroundColor(Color.textSecondary)
        .font(.system(size: width * scale, weight: .semibold))
    }
    
    // Deal link (Cheap Shark redirect)
    var link: some View {
        HStack {
            Text(.init("[Buy now](\(deal.dealURL))"))
                .font(.system(size: width * scale, weight: .semibold))
            Spacer()
        }
    }
    
}
