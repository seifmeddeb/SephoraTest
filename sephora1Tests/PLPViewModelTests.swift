//
//  PLPViewModelTests.swift
//  sephora1Tests
//
//  Created by Seif Meddeb on 05/01/2023.
//

import XCTest
@testable import sephora1

final class PLPViewModelTests: XCTestCase {

    var sut: PLPViewModelProtocol?
    let networkManagerSpy = NetworkManagerSpy()
    
    override func setUpWithError() throws {
        sut = PLPViewModel(networkManager: networkManagerSpy)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_fetch_product_list() throws {
        // When start fetch
        _ = sut?.fetchProducts()
        
        // Assert
        XCTAssert(networkManagerSpy.isFetchProductListCalled)
    }

}
