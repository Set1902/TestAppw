//
//  eeViewController.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 24.08.2022.
//

import UIKit

class eeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    
    
    @IBOutlet weak var catsales: UICollectionView!
    
    @IBOutlet weak var hotsalesLabel: UILabel!
    
    @IBOutlet weak var toplabel: UILabel!
    
    
    @IBOutlet weak var selectcat: UILabel!
    
    @IBOutlet weak var viewall: UIButton!
    
    @IBOutlet weak var search: UITextField!
    
    @IBOutlet weak var hotsales: UICollectionView!
    
    @IBOutlet weak var bestseller: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        toplabel.frame = CGRect(x: 155, y: 63, width: 199, height: 19)
        selectcat.frame = CGRect(x: 17, y: 100, width: 193, height: 32)
        viewall.frame = CGRect(x: 329, y: 107, width: 52, height: 19)
        search.frame = CGRect(x: 32, y: 284, width: 300, height: 34)
        search.layer.cornerRadius = 50
        search.placeholder = "search"
        hotsales.frame = CGRect(x: 15, y: 382, width: 363, height: 182)
        hotsales.backgroundColor = .black
        hotsales.layer.cornerRadius = 20
        bestseller.frame = CGRect(x: 17, y: 575, width: 128, height: 32)
        catsales.frame = CGRect(x: 27, y: 156, width: 378, height: 93)
        //catsales.backgroundColor = .green
        hotsalesLabel.frame = CGRect(x: 17, y: 342, width: 111, height: 32)
        catsales.delegate = self
        catsales.dataSource = self
        catsales.reloadData()
        hotsales.delegate = self
        hotsales.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        hotsales.collectionViewLayout = layout
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.hotsales {
            return 2
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.catsales {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CatCollectionViewCell
            //cellA.button.frame = CGRect(x: 0, y: 156, width: 71, height: 71)
            cellA.label.text = "hi"
            //fcellA.backgroundColor = .orange
            cellA.frame = CGRect(x: 0, y: 0, width: 71, height: 93)
            return cellA
        } else {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "cell22", for: indexPath)
            cellB.frame = CGRect(x: 0, y: 0, width: 363, height: 182)
            
            cellB.backgroundColor = .white
            return cellB
        }
    }

}
