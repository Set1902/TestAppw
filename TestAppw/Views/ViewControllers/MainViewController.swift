//
//  ViewController.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 21.08.2022.
//

import UIKit
import Combine
class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var searchw: UITextField!
    

    @IBOutlet weak var qrButton: UIButton!
    
    @IBOutlet weak var Cat: UICollectionView!
    

    
    @IBOutlet weak var best: UICollectionView!
    
 
    
    @IBOutlet weak var best2: UICollectionView!
    

    @IBOutlet weak var hotSales: UILabel!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var Label: UILabel!
    var previousSelected : IndexPath?
    var currentSelected : Int?
    
    private let cat: [String] = ["phone.phg","comp.png", "serd.png", "book.png"]
    private let catt: [String] = ["Phones", "Computer", "Health", "Books"]
    private var model = Welcome()
    private let vm = MainViewModel()
    private let input: PassthroughSubject<MainViewModel.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view

        qrButton.layer.cornerRadius = 8
        //filterww.isHidden = true
        best.layer.cornerRadius = 20
        
       
        
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
        self.tabBarController?.tabBar.isHidden = true
        //filterww.isHidden = false
        //filterww.layer.cornerRadius = 30
        //filterww.layer.masksToBounds = true
        
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
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CatCollectionViewCell
            if indexPath.item == 0 {
                cellA.imgLabel.backgroundColor = .white
                cellA.isSelected = true
                
                //cellA.label.textColor = .orange
                //cellA.imgLabel.backgroundColor = .orange
            }
            cellA.imgLabel.addImageWith(name: cat[indexPath.item], behindText: false)
            cellA.label.text = catt[indexPath.item]
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
                    cellB.label.textColor = .white
                    cellB.label2.textColor = .white
                    cellB.label.text = model.homeStore![indexPath.item].title
                    cellB.label2.text = model.homeStore![indexPath.item].subtitle
                    cellB.buyNowButton.layer.cornerRadius = 5
                    cellB.buyNowButton.backgroundColor = .white
                    return cellB
                }
        
        else {
            
            let cellC = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! Best2CollectionViewCell
            let price: String = String(model.bestSeller![indexPath.item].priceWithoutDiscount!)
            let fullPrice: String = String(model.bestSeller![indexPath.item].discountPrice!)
            cellC.price.text = "$ \(price)"
            cellC.fullPrice.text = "$ \(fullPrice)"
            cellC.fullPrice.textColor = .gray
            cellC.name.text = model.bestSeller![indexPath.item].title
            cellC.button.setImage(UIImage(named:"like.png"), for: .normal)
            like = 1
            if model.bestSeller![indexPath.item].isFavorites == true {
                cellC.button.setImage(UIImage(named:"like2.png"), for: .normal)
                like = 2
            }
            let url: String =  model.bestSeller![indexPath.item].picture!

            let imageURL = URL(string: url)

            DispatchQueue.global().async {
               let imageData = try? Data(contentsOf: imageURL!)
                
            let image = UIImage(data: imageData!)
                
                DispatchQueue.main.async {
                    cellC.image102.image = image
                }
            }
            
            cellC.layer.shadowColor = UIColor.black.cgColor
            cellC.layer.shadowOffset = CGSize(width: 0, height: 1.0)
            cellC.layer.shadowRadius = 10
            cellC.layer.shadowOpacity = 0.5
            cellC.layer.masksToBounds = false
            
            cellC.layer.cornerRadius = 10
            
            
            
            return cellC
        }
    }
    
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        


    }
    
    
    
    
    
}

extension MainViewController {
    
    @IBAction func unwindToMain(unwindSegue: UIStoryboardSegue) {

    }
    
}

extension UILabel {

    func addImageWith(name: String, behindText: Bool) {

        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: name)
        let attachmentString = NSAttributedString(attachment: attachment)

        guard let txt = self.text else {
            return
        }

        if behindText {
            let strLabelText = NSMutableAttributedString(string: txt)
            strLabelText.append(attachmentString)
            self.attributedText = strLabelText
        } else {
            let strLabelText = NSAttributedString(string: txt)
            let mutableAttachmentString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)
            self.attributedText = mutableAttachmentString
        }
    }
}


