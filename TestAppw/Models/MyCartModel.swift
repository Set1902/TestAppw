//
//  MyCartModel.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 21.08.2022.
//

import Foundation

// MARK: - Cart
struct MyCart: Codable {
    let basket: [Basket]
    let delivery, id: String
    let total: Int
}

// MARK: - Basket
struct Basket: Codable {
    let id: Int
    let images: String
    let price: Int
    let title: String
}
