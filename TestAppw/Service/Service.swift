//
//  Service.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 21.08.2022.
//

import Foundation


import Foundation
import Combine
import UIKit
protocol ServiceProtocol {
    func getMainModel() -> AnyPublisher<Welcome, Error>
    func getProductDetail() -> AnyPublisher<Details, Error>
    func getMyCart() -> AnyPublisher<MyCart, Error>

}

class Sevice: ServiceProtocol {
    
    func getMainModel() -> AnyPublisher<Welcome, Error> {
      let url = URL(string: "https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175")
      return URLSession.shared.dataTaskPublisher(for: url!)
        .catch { error in
          return Fail(error: error).eraseToAnyPublisher()
        }.map({ $0.data })
        .decode(type: Welcome.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
    
    func getProductDetail() -> AnyPublisher<Details, Error> {
      let url = URL(string: "https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5")
      return URLSession.shared.dataTaskPublisher(for: url!)
        .catch { error in
          return Fail(error: error).eraseToAnyPublisher()
        }.map({ $0.data })
        .decode(type: Details.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
    
    func getMyCart() -> AnyPublisher<MyCart, Error> {
      let url = URL(string: "https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149")
      return URLSession.shared.dataTaskPublisher(for: url!)
        .catch { error in
          return Fail(error: error).eraseToAnyPublisher()
        }.map({ $0.data })
        .decode(type: MyCart.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
}
