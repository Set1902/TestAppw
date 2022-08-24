//
//  CatCollectionViewCell.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 23.08.2022.
//

import UIKit

class CatCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = button.frame.width / 2
        button.layer.masksToBounds = true
    
    }

    
    @IBAction func buttonTapped(_ sender: Any) {
        
        button.backgroundColor = .white
        
    }
    
    
    
}
