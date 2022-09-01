//
//  SheetViewController.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 24.08.2022.
//

import UIKit




class SheetViewController: UIViewController, UISheetPresentationControllerDelegate {

    
    @IBOutlet weak var button: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
                .large()
            ]
            presentationController.prefersGrabberVisible = true
        }
    }
    
    
    
    
    
    

}
