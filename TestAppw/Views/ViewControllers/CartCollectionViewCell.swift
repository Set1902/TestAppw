//
//  CartCollectionViewCell.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 30.08.2022.
//

import UIKit

class CartCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var image104: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet weak var labelCount: UILabel!
    
    var num: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelCount.text = String(num)
    }
    
    @IBAction func minusButtonTapped(_ sender: Any) {
        
        num -= 1
        labelCount.text = String(num)
        
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        
        num += 1
        labelCount.text = String(num)
    }
    
    
}
