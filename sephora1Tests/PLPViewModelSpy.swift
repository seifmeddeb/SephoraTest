//
//  PLPViewModelSpy.swift
//  sephora1Tests
//
//  Created by Seif Meddeb on 05/01/2023.
//

import Foundation
@testable import sephora1
import Combine

class PLPViewModelSpy: PLPViewModelProtocol {
    var isFetchProductsCalled = false
    
    func fetchProducts() -> PassthroughSubject<[DisplayableProduct], Error> {
        isFetchProductsCalled = true
        return PassthroughSubject<[DisplayableProduct], Error>()
    }
}
