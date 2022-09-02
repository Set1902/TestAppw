//
//  MyCartViewController.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 21.08.2022.
//

import UIKit
import Combine

class MyCartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var checkoutButton: UIButton!
    
    @IBOutlet weak var finalPricee: UILabel!
    
    @IBOutlet weak var cart: UICollectionView!
    
    @IBOutlet weak var Label: UILabel!
    
    
    
    @IBOutlet weak var backButton: UIButton!
    
    
    
    private var myCart = MyCart()
    private let vm = MyCartViewModel()
    private let input: PassthroughSubject<MyCartViewModel.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backButton.layer.cornerRadius = 10
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
              self?.updateUI(with: cart)
          case .fetchMyCartDidFail(let error):
              print(error)
          }
        }.store(in: &cancellables)
        
    }
    
    private func updateUI(with mycart: MyCart) {
        cart.dataSource = self
        cart.delegate = self
        cart.layer.cornerRadius = 30
        //cart.backgroundColor = .systemBlue
        
        self.myCart = mycart
        updateFinalPrice()
    }
    
    private func updateFinalPrice() {
        finalPricee.text = "$\(myCart.total!) us"
        Label.text = myCart.delivery!
        
        checkoutButton.layer.cornerRadius = 10
        checkoutButton.backgroundColor = .orange
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myCart.basket!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "cell7", for: indexPath) as! CartCollectionViewCell
        //cellA.backgroundColor = .systemPink
        cellA.nameLabel.text = myCart.basket![indexPath.item].title!
        let pp: String = String(myCart.basket![indexPath.item].price!)
        cellA.priceLabel.text = "$\(pp)"
        cellA.label.layer.cornerRadius = 20
        cellA.label.layer.masksToBounds = true
        
        let url: String = myCart.basket![indexPath.item].images!

        let imageURL = URL(string: url)

        DispatchQueue.global().async {
            let imageData = try? Data(contentsOf: imageURL!)
            
            let image = UIImage(data: imageData!)
            
            DispatchQueue.main.async {
                cellA.image104.image = image
            }
        }
        
        cellA.image104.layer.cornerRadius = 10
        
        return cellA
    }
    
    
    
    
}
