//
//  ProdDetCollectionViewCell.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 24.08.2022.
//

import UIKit

class ProdDetCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var shopButton: UIButton!
    
    @IBOutlet weak var detailsButton: UIButton!
    
    @IBOutlet weak var featuresButton: UIButton!
    
    @IBOutlet weak var label: UILabel!
    
    
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var label4: UILabel!
    
    @IBOutlet weak var label5: UILabel!
    
    @IBOutlet weak var firstButton: UIButton!
    
    
    @IBOutlet weak var secondButton: UIButton!
    
    
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var colorBurronfirst: UIButton!
    
    
    @IBOutlet weak var colorButtonsecond: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        firstButton.backgroundColor = .orange
        secondButton.backgroundColor = .white
        firstButton.layer.cornerRadius = 10
        secondButton.layer.cornerRadius = 10
        colorBurronfirst.layer.cornerRadius = colorBurronfirst.frame.width / 2
        colorButtonsecond.layer.cornerRadius = colorButtonsecond.frame.width / 2
        colorBurronfirst.setImage(UIImage(named: "Vector-9.png"), for: .normal)
        
        

    }
    
    
    @IBAction func firstButtonTapped(_ sender: Any) {
        firstButton.backgroundColor = .orange
        secondButton.backgroundColor = .white
    }
    
    @IBAction func secondButtonTapped(_ sender: Any) {
        firstButton.backgroundColor = .white
        secondButton.backgroundColor = .orange
    }
    
    @IBAction func colorFirstButtonTapped(_ sender: Any) {
        colorBurronfirst.setImage(UIImage(named: "Vector-9.png"), for: .normal)
        colorButtonsecond.setImage(nil, for: .normal)
    }
    
    @IBAction func colorSecondButtonTapped(_ sender: Any) {
        colorBurronfirst.setImage(nil, for: .normal)
        colorButtonsecond.setImage(UIImage(named: "Vector-9.png"), for: .normal)
    }
    
}
