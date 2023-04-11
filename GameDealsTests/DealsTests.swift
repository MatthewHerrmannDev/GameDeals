// Description: Class to test Deals class
// Author:      Matthew Herrmann
// Project:     GameDeals
// Date:        April 10, 2023

import XCTest
import Combine
@testable import GameDeals

final class DealsTests: XCTestCase {

    var deals: Deals!
    private var cancelables: Set<AnyCancellable>!
    
    override func setUp() async throws {
        deals = await Deals(api: MockAPI(), location: "MockDeals")
        cancelables = []
    }
    
    override func tearDown() async throws {
        deals = nil
        cancelables = nil
    }
    
    // Test for proper decoding
    func testFetchDeals() async throws {
        let expectation = XCTestExpectation(description: "Fetched Stores")
        
        await deals.fetch()
        
        await deals
            .$contents
            .sink { value in
                XCTAssertEqual(value.count, 2)
                expectation.fulfill()
            }
            .store(in: &cancelables)
        
        wait(for: [expectation], timeout: 1)
    }

}
