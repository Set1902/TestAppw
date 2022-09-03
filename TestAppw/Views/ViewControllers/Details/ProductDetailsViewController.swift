//
//  ProductDetailsViewController.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 21.08.2022.
//

import UIKit
import Combine
class ProductDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var imagecur: UICollectionView!
    
    @IBOutlet weak var gotoCartButton: UIButton!
    
    @IBOutlet weak var detaildd: UICollectionView!
    
    
    
    private var detail = Details()
    private let vm = ProductDetailsViewModel()
    private let input: PassthroughSubject<ProductDetailsViewModel.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        backButton.layer.cornerRadius = 10
        gotoCartButton.layer.cornerRadius = 10
        
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
              self?.updateUI(with: detail)
          case .fetchProductDetailDidFail(let error):
              print(error)
          }
        }.store(in: &cancellables)
        
    }
    
    
    func updateUI(with detail: Details){
        detaildd.delegate = self
        detaildd.dataSource = self
        detaildd.layer.shadowRadius = 30
        detaildd.layer.shadowColor = UIColor.black.cgColor
        detaildd.layer.shadowOpacity = 0.10
        detaildd.layer.shadowOffset = CGSize(width: 0, height: 5)
        detaildd.layer.cornerRadius = 30
        imagecur.delegate = self
        imagecur.dataSource = self
        detaildd.isScrollEnabled = true
        self.detail = detail
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.imagecur {
            return detail.images!.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.imagecur {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "cell6", for: indexPath) as! detailCollectionViewCell
            
            let url: String =  detail.images![indexPath.item]

            let imageURL = URL(string: url)

            DispatchQueue.global().async {
               let imageData = try? Data(contentsOf: imageURL!)
                
            let image = UIImage(data: imageData!)
                
                DispatchQueue.main.async {
                    cellB.image103.image = image
                }
            }
            
            return cellB
        } else {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "detcell", for: indexPath) as! ProdDetCollectionViewCell
            cellA.label.text = detail.title!
            cellA.button.backgroundColor = .orange
            cellA.backgroundColor = .white
            cellA.button.layer.cornerRadius = 10
            cellA.label2.text = detail.cpu!
            cellA.label3.text = detail.camera!
            cellA.label4.text = detail.sd!
            cellA.label5.text = detail.ssd!
            cellA.button.setTitle("Add to Cart  $\(detail.price!)", for: .normal)
            return cellA
        }
        
        
    }
    
}


extension ProductDetailsViewController {
    @IBAction func unwindToDetails(unwindSegue: UIStoryboardSegue) {
        
    }
    
}
