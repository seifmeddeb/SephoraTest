//
//  Product.swift
//  sephora1
//
//  Created by Seif Meddeb on 04/01/2023.
//

import Foundation

struct Product: Codable {
    let productID: Int
    let productName, description: String
    let price: Double
    let imagesURL: ImagesURL
    let cBrand: CBrand
    let isProductSet, isSpecialBrand: Bool
    
    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
        case productName = "product_name"
        case description = "description"
        case price = "price"
        case imagesURL = "images_url"
        case cBrand = "c_brand"
        case isProductSet = "is_productSet"
        case isSpecialBrand = "is_special_brand"
    }
}

// MARK: - CBrand
struct CBrand: Codable {
    let id, name: String
}

// MARK: - ImagesURL
struct ImagesURL: Codable {
    let small: String
    let large: String
}
