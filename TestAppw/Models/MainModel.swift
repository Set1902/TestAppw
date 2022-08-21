//
//  MainModel.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 21.08.2022.
//

import Foundation


// MARK: - Welcome
struct Welcome: Decodable {
    var homeStore: [HomeStore]?
    var bestSeller: [BestSeller]?

    enum CodingKeys: String, CodingKey {
        case homeStore = "home_store"
        case bestSeller = "best_seller"
    }
}

// MARK: - BestSeller
struct BestSeller: Decodable {
    var id: Int?
    var isFavorites: Bool?
    var title: String?
    var priceWithoutDiscount, discountPrice: Int?
    var picture: String?

    enum CodingKeys: String, CodingKey {
        case id
        case isFavorites = "is_favorites"
        case title
        case priceWithoutDiscount = "price_without_discount"
        case discountPrice = "discount_price"
        case picture
    }
}

// MARK: - HomeStore
struct HomeStore: Decodable {
    var id: Int?
    var isNew: Bool?
    var title, subtitle: String?
    var picture: String?
    var isBuy: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case isNew = "is_new"
        case title, subtitle, picture
        case isBuy = "is_buy"
    }
}
