//
//  PLPViewModel.swift
//  sephora1
//
//  Created by Seif Meddeb on 04/01/2023.
//

import Foundation
import Combine

protocol PLPViewModelProtocol {
    func fetchProducts() -> PassthroughSubject<[DisplayableProduct], Error>
}

class PLPViewModel: PLPViewModelProtocol {
    
    var networkManager: NetworkProtocol
    var plpSubject: PassthroughSubject<[DisplayableProduct], Error> = PassthroughSubject<[DisplayableProduct], Error>()
    
    init(networkManager: NetworkProtocol) {
        self.networkManager = networkManager
    }

    func fetchProducts() -> PassthroughSubject<[DisplayableProduct], Error> {
        networkManager.getProductsList { [weak self] products, error in
            var displayableProducts = products.compactMap {
                DisplayableProduct(name: $0.productName,
                                   description: $0.description,
                                   price: "\($0.price)€",
                                   imageURL: $0.imagesURL.small,
                                   isSpecialBrand: $0.isSpecialBrand)
            }
            displayableProducts.sort{ $0.isSpecialBrand && !$1.isSpecialBrand }
            self?.plpSubject.send(displayableProducts)
        }
        return plpSubject
    }
}
