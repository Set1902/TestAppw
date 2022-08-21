//
//  MyCartViewModel.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 21.08.2022.
//

import Foundation
import UIKit
import Combine


class MyCartViewModel {
    
    enum Input {
      case viewDidLoad
    }
    
    enum Output {
      case fetchMyCartDidFail(error: Error)
      case fetchMyCartDidSucceed(cart: MyCart)
    }
    
    private let myCartService: ServiceProtocol
    private let output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    init(myCartService: ServiceProtocol = Sevice()) {
      self.myCartService = myCartService
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
      input.sink { [weak self] event in
        switch event {
        case .viewDidLoad:
          self?.handleMyCartModel()
        }
      }.store(in: &cancellables)
      return output.eraseToAnyPublisher()
    }
    
    private func handleMyCartModel() {
        myCartService.getMyCart().sink { [weak self] completion in
        if case .failure(let error) = completion {
          self?.output.send(.fetchMyCartDidFail(error: error))
        }
      } receiveValue: { [weak self] cart in
          self?.output.send(.fetchMyCartDidSucceed(cart: cart))
      }.store(in: &cancellables)
    }

    
    
}
