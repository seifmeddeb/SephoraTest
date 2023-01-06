//
//  PLPViewControllerTests.swift
//  sephora1Tests
//
//  Created by Seif Meddeb on 05/01/2023.
//

import XCTest
@testable import sephora1

final class PLPViewControllerTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: PLPViewController!
    var viewModel: PLPViewModelProtocol?
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        window = UIWindow()
        sut = PLPViewController()
    }
    
    override func tearDown()
    {
        window = nil
        super.tearDown()
    }
    
    func loadView()
    {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    func test_should_call_viewModel_when_view_is_loaded()
      {
        // Given
        let spy = PLPViewModelSpy()
        sut.viewModel = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.isFetchProductsCalled, "viewDidLoad() should call viewModel.fetchProducts")
      }
    
}
