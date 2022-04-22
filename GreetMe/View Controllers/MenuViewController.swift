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
    @IBOutlet weak var addNewCardLabel: UILabel!
    @IBOutlet weak var viewPriorCardsLabel: UILabel!
     

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print("MenuViewController viewWillDisapper Called")
    }
    
    
    // https://stackoverflow.com/questions/56960977/how-to-correctly-dismiss-previous-view-controller
    @IBAction func createNewCardSegue(_ sender: Any) {
        performSegue(withIdentifier: "menuToPhoto", sender: nil)
        //let controller = self.storyboard!.instantiateViewController(withIdentifier: "NewCardMenuViewController") as UIViewController
        //self.present(controller, animated: true, completion: nil)
        //}

    }

    // https://stackoverflow.com/questions/56960977/how-to-correctly-dismiss-previous-view-controller
    @IBAction func viewPriorCardsSegue(_ sender: Any) {
        performSegue(withIdentifier: "menuToPriorCards", sender: nil)
        //let controller = self.storyboard!.instantiateViewController(withIdentifier: "PriorCardsViewController") as UIViewController
        //self.present(controller, animated: true, completion: nil)
    }
    
}
