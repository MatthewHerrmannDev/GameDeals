// Description: Main struct for the app
// Author:      Matthew Herrmann
// Project:     VideoGameDeals
// Date:        April 10, 2023

import SwiftUI

@main
struct GameDealsApp: App {
    var body: some Scene {
        WindowGroup {
            DealGrid()
        }
    }
}
