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
    @IBOutlet weak var settingButton: UIButton!
    var buttonConfig = UIButton.Configuration.filled()

    @IBOutlet weak var addNewCardLabel: UILabel!
    @IBOutlet weak var viewPriorCardsLabel: UILabel!
    @IBOutlet weak var settingLabel: UILabel!
     
    func sizeButtonImages() {
        let frame = CGRect(x: 10, y: 10, width: self.view.frame.width - 20, height: 300)
         self.settingButton.imageView?.frame = frame
        print("ran sizeButtonImages")

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        sizeButtonImages()
    }
    

    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        sizeButtonImages()
    }
    
}
