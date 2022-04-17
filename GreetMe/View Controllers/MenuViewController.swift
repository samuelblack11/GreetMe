//
//  MenuViewController.swift
//  GreetMe
//
//  Created by Sam Black on 3/30/22.
//

import Foundation
import UIKit
import CoreData


class MenuViewController: UIViewController {
    
    var container: NSPersistentContainer!

    @IBOutlet weak var addNewCardButton: UIButton!
    @IBOutlet weak var viewPriorCardsButton: UIButton!
    var buttonConfig = UIButton.Configuration.filled()

    @IBOutlet weak var addNewCardLabel: UILabel!
    @IBOutlet weak var viewPriorCardsLabel: UILabel!
     
    func sizeButtonImages() {
        //let frame = CGRect(x: 10, y: 10, width: self.view.frame.width - 20, height: 300)
         //self.settingButton.imageView?.frame = frame
        //print("ran sizeButtonImages")

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        sizeButtonImages()
    }
    

    @IBAction func clickSettings(_ sender: Any) {
    // https://stackoverflow.com/questions/24195310/how-to-add-an-action-to-a-uialertview-button-using-swift-ios
        let alertController = UIAlertController(title: "This Feature is Not Yet Available", message: "Please try the other buttons", preferredStyle: .alert)
            
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default) {
                UIAlertAction in NSLog("Dismiss Pressed")
        }
            
        alertController.addAction(dismissAction)
        self.present(alertController,animated: true, completion: nil)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        sizeButtonImages()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print("MenuViewController viewWillDisapper Called")
    }
    
    
    @IBAction func createNewCardSegue(_ sender: Any) {
        //performSegue(withIdentifier: "menuToNewCardMenu", sender: nil)
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "NewCardMenuViewController") as UIViewController
        self.present(controller, animated: true, completion: nil)
    }

    @IBAction func viewPriorCardsSegue(_ sender: Any) {
       // performSegue(withIdentifier: "menuToPriorCards", sender: nil)
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "PriorCardsViewController") as UIViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    
    
    
}
