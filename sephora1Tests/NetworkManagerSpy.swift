//
//  NetworkManagerSpy.swift
//  sephora1Tests
//
//  Created by Seif Meddeb on 05/01/2023.
//

import Foundation
@testable import sephora1

class NetworkManagerSpy: NetworkProtocol {
    var isFetchProductListCalled = false
    
    func getProductsList(completion: @escaping ([Product], Error?) -> Void) {
        isFetchProductListCalled = true
    }
}
