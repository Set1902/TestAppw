//
//  ProductDetailsViewController.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 21.08.2022.
//

import UIKit
import Combine
class ProductDetailsViewController: UIViewController {

    
    
    @IBOutlet weak var Label: UILabel!
    
    
    private var detail = Details()
    private let vm = ProductDetailsViewModel()
    private let input: PassthroughSubject<ProductDetailsViewModel.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bind()
        input.send(.viewDidLoad)
    }
    
    private func bind() {

        let output = vm.transform(input: input.eraseToAnyPublisher())
        output
          .receive(on: DispatchQueue.main)
          .sink { [weak self] event in
          switch event {
          case .fetchProductDetailDidSucceed(let detail):
              self?.Label.text = detail.title!
          case .fetchProductDetailDidFail(let error):
              print(error)
          }
        }.store(in: &cancellables)
        
    }
}
