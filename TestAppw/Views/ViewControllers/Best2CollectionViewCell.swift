//
//  Best2CollectionViewCell.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 23.08.2022.
//

import UIKit

class Best2CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image102: UIImageView!
    
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    
    @IBOutlet weak var fullPrice: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        
        
           // button.backgroundColor = .white
        button.setImage(UIImage(named:"like2.png"), for: .normal)
        
            
        
        
        
    }
    
    
}
