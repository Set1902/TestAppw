//
//  DetailModel.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 21.08.2022.
//

import Foundation


// MARK: - Details
struct Details: Decodable {
    var cpu, camera: String?
    var capacity, color: [String]?
    var id: String?
    var images: [String]?
    var isFavorites: Bool?
    var price: Int?
    var rating: Double?
    var sd, ssd, title: String?

    enum CodingKeys: String, CodingKey {
        case cpu = "CPU"
        case camera, capacity, color, id, images, isFavorites, price, rating, sd, ssd, title
    }
}
