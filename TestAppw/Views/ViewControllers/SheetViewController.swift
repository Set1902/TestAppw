//
//  SheetViewController.swift
//  TestAppw
//
//  Created by Sergei Kovalev on 24.08.2022.
//

import UIKit




class SheetViewController: UIViewController, UISheetPresentationControllerDelegate {

    
    
    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.prefersScrollingExpandsWhenScrolledToEdge = false
        sheetPresentationController.preferredCornerRadius = 50
        sheetPresentationController.detents = [
            .medium()
        ]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
