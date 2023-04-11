// Description: Cell containing deal info from Cheap Shark
// Author:      Matthew Herrmann
// Project:     VideoGameDeals
// Date:        April 10, 2023

import SwiftUI
import SDWebImageSwiftUI

struct DealCell: View {
    
    @EnvironmentObject var stores: Stores
    let deal: Deal
    let size: Double
    private let scale = 0.1
    
    var body: some View {
        // If tapped, go to deal page
        NavigationLink(value: deal) {
            VStack(spacing: 0) {
                image
                info
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
        }
    }
    
    // Image of game
    var image: some View {
        WebImage(url: deal.thumbURL)
            .placeholder { Color.textSecondary }
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size / 3)
            .clipped()
    }
    
    // Deal info
    var info: some View {
        ZStack {
            Color.backgroundSecondary
            VStack(spacing: 0) {
                title
                separator
                HStack {
                    price
                    Spacer()
                    icon
                }
                .frame(width: size * 0.9)
            }
        }
        .frame(width: size, height: size * 2 / 3)
    }
    
    // Title of game
    var title: some View {
        Text(deal.title)
            .multilineTextAlignment(.leading)
            .foregroundColor(Color.textPrimary)
            .font(.system(size: size * scale, weight: .bold))
            .frame(width: size * 0.9, height: size * 0.4, alignment: .topLeading)
    }
    
    // Line separator
    var separator: some View {
        Color.separator
            .frame(width: size, height: size / 200)
            .padding(.bottom, size / 25)
    }
    
    // Deal price
    var price: some View {
        HStack(spacing: size / 40) {
            // If on-sale, include regular price
            if (deal.isOnSale == "1") {
                Text("$\(deal.normalPrice)")
                    .strikethrough()
            }
            Text("$\(deal.salePrice)")
        }
        .foregroundColor(Color.textSecondary)
        .font(.system(size: size * scale * 0.8, weight: .semibold))
        .frame(height: size * scale)
    }
    
    // Store icon
    var icon: some View {
        WebImage(url: stores.contents[deal.storeID]!.images.iconURL)
            .placeholder { Color.backgroundSecondary }
            .resizable()
            .scaledToFill()
            .frame(width: size * scale, height: size * scale)
    }
    
}
