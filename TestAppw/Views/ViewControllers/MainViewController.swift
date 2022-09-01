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
    
    @IBOutlet weak var bestCeller: UILabel!
    
    @IBOutlet weak var best: UICollectionView!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var best2: UICollectionView!
    
    @IBOutlet weak var filter: UIButton!
    
    
    @IBOutlet weak var filtercollect: UICollectionView!
    
    
    @IBOutlet weak var hotSales: UILabel!
    
    
    @IBOutlet weak var filterww: UILabel!
    
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var Label: UILabel!
    var previousSelected : IndexPath?
    var currentSelected : Int?
    
    private let cat: [String] = ["comp.png", "serd.png", "book.png"]
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
            return cat.count + 1
               }
        else if collectionView == self.best {
            return model.homeStore!.count
        }
        else if collectionView == self.filtercollect {
            return 1
        }
        return model.bestSeller!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.Cat {
                    let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CatCollectionViewCell
            
            cellA.imgLabel.addImageWith(name: cat[0], behindText: false)
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
            cellC.name.text = model.bestSeller![indexPath.item].title
            cellC.button.layer.cornerRadius = cellC.button.frame.width / 2

            cellC.button.backgroundColor = .white
            cellC.button.setImage(UIImage(named:"like.png"), for: .normal)
            
            if model.bestSeller![indexPath.item].isFavorites == true {
                cellC.button.setImage(UIImage(named:"like2.png"), for: .normal)
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
            return cellC
        }
    }
    
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        
        let sheetViewController = SheetViewController(nibName: nil, bundle: nil)
                
                // Present it w/o any adjustments so it uses the default sheet presentation.
                present(sheetViewController, animated: true, completion: nil)
        
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


