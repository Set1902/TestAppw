//
//  ProductDetailsViewController.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 21.08.2022.
//

import UIKit
import Combine
class ProductDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    

    
    @IBOutlet weak var detaildd: UICollectionView!
    
    
    
    private var detail = Details()
    private let vm = ProductDetailsViewModel()
    private let input: PassthroughSubject<ProductDetailsViewModel.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        
        detaildd.delegate = self
        detaildd.dataSource = self
        detaildd.backgroundColor = .systemPink
        
        
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
              print("hi")
          case .fetchProductDetailDidFail(let error):
              print(error)
          }
        }.store(in: &cancellables)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "detcell", for: indexPath) as! ProdDetCollectionViewCell
       // cellA.label.text = "hi"
        //cellA.label2.text = "hello"
        return cellA
    }
    
}
