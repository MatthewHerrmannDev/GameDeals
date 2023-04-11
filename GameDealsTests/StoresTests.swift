// Description: Class to test Stores class
// Author:      Matthew Herrmann
// Project:     VideoGameDeals
// Date:        April 10, 2023

import XCTest
import Combine
@testable import GameDeals

final class StoresTests: XCTestCase {

    var stores: Stores!
    private var cancelables: Set<AnyCancellable>!
    
    override func setUp() async throws {
        stores = await Stores(api: MockAPI(), location: "MockStores")
        cancelables = []
    }
    
    override func tearDown() async throws {
        stores = nil
        cancelables = nil
    }
    
    // Test for proper decoding
    func testFetchStores() async throws {
        let expectation = XCTestExpectation(description: "Fetched Stores")
        
        await stores.fetch()
        
        await stores
            .$contents
            .sink { value in
                XCTAssertEqual(value.count, 3)
                expectation.fulfill()
            }
            .store(in: &cancelables)
        
        wait(for: [expectation], timeout: 1)
    }

}
