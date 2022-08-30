//
//  MyCartViewController.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 21.08.2022.
//

import UIKit
import Combine

class MyCartViewController: UIViewController {
    
    
    @IBOutlet weak var Label: UILabel!
    
    private var myCart = MyCart()
    private let vm = MyCartViewModel()
    private let input: PassthroughSubject<MyCartViewModel.Input, Never> = .init()
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
          case .fetchMyCartDidSucceed(let cart):
            print("hi")
              //self?.Label.text = cart.basket![0].title
          case .fetchMyCartDidFail(let error):
              print(error)
          }
        }.store(in: &cancellables)
        
    }
}
