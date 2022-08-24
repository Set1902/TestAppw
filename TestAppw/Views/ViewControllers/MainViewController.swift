//
//  ViewController.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 21.08.2022.
//

import UIKit
import Combine
class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet weak var scroller: UIScrollView!
    
    @IBOutlet weak var Cat: UICollectionView!
    
    @IBOutlet weak var bestCeller: UILabel!
    
    @IBOutlet weak var best: UICollectionView!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var best2: UICollectionView!
    
    @IBOutlet weak var filter: UIButton!
    
    @IBOutlet weak var Label: UILabel!
    
    private let cat: [String] = ["comp.png", "serd.png", "book.png"]
    private var model = Welcome()
    private let vm = MainViewModel()
    private let input: PassthroughSubject<MainViewModel.Input, Never> = .init()
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
          case .fetchMainModelDidSucceed(let model):
              //print("hi")
              self?.updateUI(with: model)
              //self?.Label.text = model.bestSeller![1].title
          case .fetchMainModelDidFail(let error):
              print(error)
          }
        }.store(in: &cancellables)
        
    }
    
    private func updateUI(with model: Welcome) {

        Cat.dataSource = self
        Cat.delegate = self
        best.dataSource = self
        best.delegate = self
        best2.dataSource = self
        best2.delegate = self
        
        self.model = model

        self.Cat.reloadData()
        self.best.reloadData()
        self.best2.reloadData()
        
    }

    @IBAction func ButtonTapped(_ sender: Any) {
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.Cat {
            return cat.count
               }
        else if collectionView == self.best {
            return model.homeStore!.count
        }
        return model.bestSeller!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.Cat {
            let layout = UICollectionViewFlowLayout()
            //layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 24, left: 0, bottom: 57, right: 0)
            
            layout.minimumInteritemSpacing = 23
            
            Cat.collectionViewLayout = layout
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CatCollectionViewCell
            
            cellA.button.setImage(UIImage(named:cat[indexPath.item]), for: .normal)
            cellA.button.contentVerticalAlignment = .fill
            cellA.button.contentHorizontalAlignment = .fill
            cellA.button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            cellA.backgroundColor = .white
            return cellA
                }

                else if collectionView == self.best{
                    
                    let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! HotSalesCollectionViewCell
                    cellB.backgroundColor = .black
                                        
                    
    
                    
                    let url: String =  model.homeStore![indexPath.item].picture!

                    let imageURL = URL(string: url)

                    DispatchQueue.global().async {
                        let imageData = try? Data(contentsOf: imageURL!)
                        
                        let image = UIImage(data: imageData!)
                        
                        DispatchQueue.main.async {
                            cellB.image101.image = image
                        }
                    }
                    
                    cellB.label.text = model.homeStore![indexPath.item].title
                    cellB.label2.text = model.homeStore![indexPath.item].subtitle
                    

                    return cellB
                }
        else {
            
            let cellC = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! Best2CollectionViewCell
            let price: String = String(model.bestSeller![indexPath.item].priceWithoutDiscount!)
            let fullPrice: String = String(model.bestSeller![indexPath.item].discountPrice!)
            cellC.price.text = "$ \(price)"
            cellC.fullPrice.text = "$ \(fullPrice)"
            cellC.name.text = model.bestSeller![indexPath.item].title
            cellC.button.layer.cornerRadius = cellC.button.frame.width / 2
            cellC.button.layer.masksToBounds = true
            cellC.button.setImage(UIImage(named:"like.png"), for: .normal)
            
            if model.bestSeller![indexPath.item].isFavorites == true {
                cellC.button.backgroundColor = .systemOrange
            }
            let url: String =  model.bestSeller![indexPath.item].picture!

            let imageURL = URL(string: url)

            //DispatchQueue.global().async {
              // let imageData = try? Data(contentsOf: imageURL!)
                
               // let image = UIImage(data: imageData!)
                
               // DispatchQueue.main.async {
               //     cellC.image102.image = image
               // }
           // }
            return cellC
        }
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        
        
        
        
        
    }
    
    @IBAction func filterTapped(_ sender: Any) {
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let sheetPC = self.storyboard?.instantiateViewController(withIdentifier: "SheetVC") as! SheetViewController
        self.present(sheetPC, animated: true, completion: nil)
        
    }
    
}


extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.best {
        
            return CGSize(width: 350, height: 150)
        } else if collectionView == self.best2 {
            
            return CGSize(width: 181, height: 227)
        } else if collectionView == self.Cat {
            
            return CGSize(width: 71, height: 71)
        }
        return CGSize(width: 71, height: 71)
    }
    
}

