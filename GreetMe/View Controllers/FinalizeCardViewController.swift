//
//  FinalizeCardViewController.swift
//  GreetMe
//
//  Created by Sam Black on 4/2/22.
//

import Foundation
import UIKit
import CoreData

class FinalizeCardViewController: UIViewController {
    
    var noteImage: Data?
    var collageImage: Data?
    var name: String!
    var occassion: String?
    
    @IBOutlet weak var collageView: UIImageView!
    @IBOutlet weak var noteView: UIImageView!
    @IBOutlet weak var recipientPhone: UITextField!
    @IBOutlet weak var recipientEmail: UITextField!
    @IBOutlet weak var cardStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collageView.image = UIImage(data: collageImage!)
        noteView.image = UIImage(data: noteImage!)
        imageFill(imageView: collageView)
        imageFill(imageView: noteView)
        
        }
        
    
    func imageFill(imageView: UIImageView!) {
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
    }

    @IBAction func sendCard(_ sender: Any) {
        // Save to Core Data

        let card = Card(context: DataController.shared.viewContext)

        card.visual = collageImage!
        card.note = noteImage!
        card.recipient = name!
        card.occassion = occassion!
        
        
        self.saveContext()
            
        debugPrint("Context Saved")
                
        // https://stackoverflow.com/questions/1134289/cocoa-core-data-efficient-way-to-count-entities
        // Print Count of Visuals Saved
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
        let count = try! DataController.shared.viewContext.count(for: fetchRequest)
        print("\(count) Cards Saved")
                
    }
    
    
    func saveContext() {
        if DataController.shared.viewContext.hasChanges {
            do {
                try DataController.shared.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }

    
    
    
    
}
