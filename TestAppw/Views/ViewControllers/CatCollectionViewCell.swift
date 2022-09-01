//
//  CatCollectionViewCell.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 23.08.2022.
//

import UIKit

class CatCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var label: UILabel!
    

    @IBOutlet weak var imgLabel: UILabel!
    
    override var isSelected: Bool {
            didSet {
                self.imgLabel.backgroundColor = isSelected ? .orange : .white
                self.label.textColor = isSelected ? .orange : .black
            }
        
        }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //button.backgroundColor = .systemOrange
        imgLabel.layer.cornerRadius = imgLabel.frame.width / 2
        imgLabel.layer.masksToBounds = true
        

    }
    
    
    
}
