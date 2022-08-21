//
//  MainViewModel.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 21.08.2022.
//

import Foundation
import Combine
import UIKit

class MainViewModel {
    
    enum Input {
      case viewDidLoad
    }
    
    enum Output {
      case fetchMainModelDidFail(error: Error)
      case fetchMainModelDidSucceed(model: Welcome)
    }
    
    
    private let modelService: ServiceProtocol
    private let output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    init(modelService: ServiceProtocol = Sevice()) {
      self.modelService = modelService
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
      input.sink { [weak self] event in
        switch event {
        case .viewDidLoad:
          self?.handleGetMainModel()
        }
      }.store(in: &cancellables)
      return output.eraseToAnyPublisher()
    }
    
    private func handleGetMainModel() {
        modelService.getMainModel().sink { [weak self] completion in
        if case .failure(let error) = completion {
          self?.output.send(.fetchMainModelDidFail(error: error))
        }
      } receiveValue: { [weak self] model in
          self?.output.send(.fetchMainModelDidSucceed(model: model))
      }.store(in: &cancellables)
    }
    
}
