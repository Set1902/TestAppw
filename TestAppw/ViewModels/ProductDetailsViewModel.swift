//
//  ProductDetailsViewModel.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 21.08.2022.
//

import Foundation
import Combine
import UIKit

class ProductDetailsViewModel {
    
    enum Input {
      case viewDidLoad
    }
    
    enum Output {
      case fetchProductDetailDidFail(error: Error)
      case fetchProductDetailDidSucceed(detail: Details)
    }
    
    private let detailService: ServiceProtocol
    private let output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    init(detailService: ServiceProtocol = Sevice()) {
      self.detailService = detailService
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
      input.sink { [weak self] event in
        switch event {
        case .viewDidLoad:
          self?.handleProductDetailModel()
        }
      }.store(in: &cancellables)
      return output.eraseToAnyPublisher()
    }
    
    private func handleProductDetailModel() {
        detailService.getProductDetail().sink { [weak self] completion in
        if case .failure(let error) = completion {
          self?.output.send(.fetchProductDetailDidFail(error: error))
        }
      } receiveValue: { [weak self] detail in
          self?.output.send(.fetchProductDetailDidSucceed(detail: detail))
      }.store(in: &cancellables)
    }
    
}
