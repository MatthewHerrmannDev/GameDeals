// Description: Page containing deal info from Cheap Shark
// Author:      Matthew Herrmann
// Project:     GameDeals
// Date:        April 10, 2023

import SwiftUI
import SDWebImageSwiftUI

struct DealPage: View {
    
    @EnvironmentObject var stores: Stores
    let deal: Deal
    let width: Double
    @State private var deals = Deals()
    @State private var loading = true
    private let scale = 0.05
    
    private var maxWidth: Double {
        if (width > 500) {
            return 500
        } else {
            return width
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                image
                name
                separator
                listing
                separator
                otherListings
                Spacer()
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        // Fetch deals for same game from other stores
        .task {
            await deals.fetch(search: deal.title, exact: true)
            deals.contents.sort { $0.salePrice < $1.salePrice }
            loading = false
        }
    }
    
    // Image of game
    var image: some View {
        WebImage(url: deal.thumbURL)
            .placeholder { Color.textSecondary }
            .resizable()
            .scaledToFill()
            .frame(width: width, height: width / 3)
            .clipped()
    }
    
    // Name of game
    var name: some View {
        Text(deal.title)
            .multilineTextAlignment(.leading)
            .foregroundColor(Color.textPrimary)
            .font(.system(size: maxWidth * scale * 1.5, weight: .bold))
            .frame(width: width * 0.9, alignment: .topLeading)
            .padding(width * scale)
    }
    
    // Line separator
    var separator: some View {
        Color.separator
            .frame(width: width, height: maxWidth * scale / 5)
    }
    
    // Deal listing
    var listing: some View {
        HStack {
            DealListing(deal: deal, width: maxWidth, scale: scale)
            Spacer()
        }
        .padding([.top, .bottom], width * scale / 2)
        .frame(width: width * 0.9)
    }
    
    // Listings at other stores
    var otherListings: some View {
        VStack(spacing: 0) {
            Text("Other Stores")
                .multilineTextAlignment(.leading)
                .foregroundColor(Color.textPrimary)
                .font(.system(size: maxWidth * scale * 1.25, weight: .bold))
                .frame(width: width * 0.9, alignment: .topLeading)
                .padding(.top, width * scale)
                .padding(.bottom, width * scale / 2)
            // Check if deals are still loading
            if (loading) {
                Text("Loading...")
            } else {
                ForEach(deals.contents) { otherDeal in
                    if (otherDeal.dealID != deal.dealID) {
                        HStack {
                            DealListing(deal: otherDeal, width: maxWidth, scale: scale)
                            Spacer()
                        }
                        .frame(width: width * 0.9)
                    }
                }
            }
        }
    }
    
}
