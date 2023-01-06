//
//  NetworkManagerTests.swift
//  sephora1Tests
//
//  Created by Seif Meddeb on 04/01/2023.
//

import XCTest
@testable import sephora1

final class NetworkManagerTests: XCTestCase {

    // custom urlsession for mock network calls
    var urlSession: URLSession!
    
    override func setUpWithError() throws {
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_get_product_list() throws {
        // Profile API. Injected with custom url session for mocking
        let networkManager = NetworkManager(urlSession: urlSession)
        
        // Set mock data
        let image = ImagesURL(small: "this is Small URL", large: "this is Large URL")
        let cBrand = CBrand(id: "12345", name: "a brand")
        let sampleProfileData = [Product(productID: 134,
                                        productName: "Hugo Boss",
                                        description: "this is a Parfum duh ?!",
                                        price: 123.4,
                                        imagesURL: image,
                                        cBrand: cBrand,
                                        isProductSet: true,
                                        isSpecialBrand: true)]
        let mockData = try JSONEncoder().encode(sampleProfileData)
        
        // Return data in mock request handler
        MockURLProtocol.requestHandler = { request in
            return (HTTPURLResponse(), mockData)
        }
        
        // Set expectation. Used to test async code.
        let expectation = XCTestExpectation(description: "response")
        
        // Make mock network request to get profile
        networkManager.getProductsList { product, error in
            // TestgetProductsList
            XCTAssertEqual(product.first?.productID ?? 0, 134)
            XCTAssertEqual(product.first?.productName ?? "", "Hugo Boss")
            XCTAssertEqual(product.first?.description ?? "", "this is a Parfum duh ?!")
            XCTAssertEqual(product.first?.price ?? 0.0, 123.4)
            XCTAssertEqual(product.first?.isProductSet ?? false, true)
            XCTAssertEqual(product.first?.isSpecialBrand ?? false, true)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }

}
