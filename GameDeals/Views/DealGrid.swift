// Description: Grid containing deals from Cheap Shark
// Author:      Matthew Herrmann
// Project:     VideoGameDeals
// Date:        April 10, 2023

import SwiftUI

struct DealGrid: View {
    
    @StateObject private var stores = Stores()
    @State private var deals = Deals()
    @State private var loading = true
    @State private var search = ""
    @State private var width = 0.0
    private let spacing = 10.0
    private let minColumnWidth = 150.0
    
    // Column amount depends on device size (min: 2, max: 4)
    private var columnAmount: Int {
        if (Int(width / minColumnWidth) < 2) {
            return 2
        } else if (Int(width / minColumnWidth) > 4) {
            return 4
        } else {
            return Int(width / minColumnWidth)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            navigation
                // If view resizes, update width
                .onAppear { width = geometry.size.width }
                .onChange(of: geometry.size) { _ in width = geometry.size.width }
        }
        .environmentObject(stores)
    }
    
    var navigation: some View {
        NavigationStack {
            dealGrid
                .navigationTitle("Deals")
                .searchable(text: $search, placement: .navigationBarDrawer(displayMode: .always))
                // Fetch stores and contents on first time
                .task {
                    if (stores.contents.count == 0) {
                        await stores.fetch()
                        await deals.fetch(search: search)
                    }
                    loading = false
                }
                // Update contents when searching
                .onChange(of: search) { _ in
                    Task {
                        loading = true
                        let searchString = search
                        // Wait for user to finish typing
                        try await Task.sleep(nanoseconds: 500_000_000)
                        // If search has changed, abandon task. Otherwise, fetch deals
                        if (search == searchString) {
                            await deals.fetch(search: search, refresh: true)
                            loading = false
                        }
                    }
                }
                // Go to full page when cell is tapped
                .navigationDestination(for: Deal.self) { deal in
                    DealPage(deal: deal, width: width - spacing * 3)
                }
        }
    }
    
    var dealGrid: some View {
        ScrollView {
            // Check if deals are still loading
            if (loading) {
                Text("Loading...")
            } else {
                LazyVGrid(columns: [GridItem](repeating: GridItem(.flexible()), count: columnAmount)) {
                    ForEach(deals.contents) { deal in
                        DealCell(deal: deal, size: (width - spacing * Double(columnAmount + 2)) / Double(columnAmount))
                        // When last deal appears, fetch more
                        .task {
                            if deal == deals.contents.last {
                                await deals.fetch(page: deals.contents.count / 60, search: search)
                            }
                        }
                    }
                }
                .padding([.leading, .trailing], spacing * 1.5)
            }
        }
        .refreshable { await deals.fetch(search: search) }
    }
    
}
