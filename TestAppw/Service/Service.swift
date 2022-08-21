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
}
