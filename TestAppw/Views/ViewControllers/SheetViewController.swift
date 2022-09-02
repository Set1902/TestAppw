//
//  SheetViewController.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 24.08.2022.
//

import UIKit




class SheetViewController: UIViewController, UISheetPresentationControllerDelegate {

    @IBOutlet weak var pullButtonone: UIButton!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var secondButton: UIButton!
    
    
    @IBOutlet weak var pullButton2: UIButton!
    
    @IBOutlet weak var pullButton3: UIButton!
    
    @IBOutlet weak var item1: UICommand!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium()
            ]
        }
        setButtons()
        
       
        
    }
    
    private func setButtons() {
        button.layer.cornerRadius = 10
        secondButton.layer.cornerRadius = 10
        setUpButtons()
        pullButtonone.layer.cornerRadius = 5
        pullButtonone.layer.borderWidth = 1
        pullButtonone.layer.borderColor = UIColor.gray.cgColor
        pullButton2.layer.cornerRadius = 5
        pullButton2.layer.borderWidth = 1
        pullButton2.layer.borderColor = UIColor.gray.cgColor
        pullButton3.layer.cornerRadius = 5
        pullButton3.layer.borderWidth = 1
        pullButton3.layer.borderColor = UIColor.gray.cgColor
    }
    
    
    private func setUpButtons() {
        
        let optionClousere = {(action: UIAction) in
            print(action.title)
        }
        
        pullButtonone.menu = UIMenu(children: [ UIAction(title: "   Samsung", handler: optionClousere)])
        pullButtonone.showsMenuAsPrimaryAction = true
        pullButtonone.changesSelectionAsPrimaryAction = true
        
        pullButton2.menu = UIMenu(children: [ UIAction(title: "   $0 - $10000", handler: optionClousere)])
        pullButton2.showsMenuAsPrimaryAction = true
        pullButton2.changesSelectionAsPrimaryAction = true
        
        pullButton3.menu = UIMenu(children: [ UIAction(title: "   4.5 to 5.5 inches", handler: optionClousere)])
        pullButton3.showsMenuAsPrimaryAction = true
        pullButton3.changesSelectionAsPrimaryAction = true
        
        
    }
    
    
    

}
