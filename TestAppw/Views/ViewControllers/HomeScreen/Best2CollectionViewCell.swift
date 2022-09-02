//
//  Best2CollectionViewCell.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 23.08.2022.
//

import UIKit

var like: Int = 0

class Best2CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image102: UIImageView!
    
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    
    @IBOutlet weak var fullPrice: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        button.layer.cornerRadius = button.frame.width / 2

        button.backgroundColor = .white
        
        
        

    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        
        if like == 2 {
            button.setImage(UIImage(named:"like.png"), for: .normal)
            like = 1
        } else {
            button.setImage(UIImage(named:"like2.png"), for: .normal)
            like = 2
        }
           // button.backgroundColor = .white
        
        
            
        
        
        
    }
    
    
}
