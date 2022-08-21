//
//  MyCartModel.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 21.08.2022.
//

import Foundation

// MARK: - Cart
struct MyCart: Decodable {
    var basket: [Basket]?
    var delivery, id: String?
    var total: Int?
}

// MARK: - Basket
struct Basket: Decodable {
    var id: Int?
    var images: String?
    var price: Int?
    var title: String?
}
