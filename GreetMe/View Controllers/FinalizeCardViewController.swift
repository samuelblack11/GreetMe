//
//  FinalizeCardViewController.swift
//  GreetMe
//
//  Created by Sam Black on 4/2/22.
//

import Foundation
import UIKit
import CoreData
import SwiftUI
import Contacts

class FinalizeCardViewController: UIViewController {
    
    var noteText: String?
    var noteFont: UIFont?
    var noteImage: Data?
    var collageImage: Data?
    var name: String!
    var occassion: String?
    @IBOutlet weak var collageView: UIImageView!
    @IBOutlet weak var noteView: UITextView!
    @IBOutlet weak var cardStack: UIStackView!
    var phoneNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collageView.image = UIImage(data: collageImage!)
        noteView.text = noteText!
        noteView.font = noteFont!
        imageFill(imageView: collageView)
        print("Completed imageFill")
        determineRecipient()
        }
        
    func imageFill(imageView: UIImageView!) {
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
    }

    // https://developer.apple.com/documentation/contacts
    func determineRecipient() {
        print("Determining Recipient")
        // Fetch contacts that have the name entered by the user on the WriteNoteViewController
        let store = CNContactStore()
        do {
            let predicate = CNContact.predicateForContacts(matchingName: name)
            let keysToFetch = [CNContactPhoneNumbersKey] as [CNKeyDescriptor]
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
            print("Fetched contacts: \(contacts)")
            if contacts.count == 0 {
                // do nothing
            }
            else if contacts[0].isKeyAvailable(CNContactPhoneNumbersKey) {
                phoneNumber = contacts[0].phoneNumbers[0].value.stringValue
                print(phoneNumber)
            }

        } catch {
            // Handle the error
            print("Can't find Phone Number for Contact Name Entered")
            }
        }
    
    @IBAction func sendCard(_ sender: Any) {
        // Create Core Data Object
        let card = Card(context: DataController.shared.viewContext)
        // Create Image of Collage/Note
        let renderer = UIGraphicsImageRenderer(size: cardStack.bounds.size)
        let cardImage = renderer.image { ctx in
            cardStack.drawHierarchy(in: cardStack.bounds, afterScreenUpdates: true)
        }
        // Save various attributes to Core Data
        card.card = (cardImage.pngData())!
        
        // https://www.hackingwithswift.com/example-code/system/how-to-save-and-load-objects-with-nskeyedarchiver-and-nskeyedunarchiver
        do {
            card.card = try NSKeyedArchiver.archivedData(withRootObject: cardStack!, requiringSecureCoding: false)
        }
        catch {
            card.card = (cardImage.pngData())!
            print("Couldn't save cardStack")
        }
        
        card.recipient = name!
        card.occassion = occassion!
        card.date = Date.now

        
        self.saveContext()
            
        debugPrint("Context Saved")
        
        // https://stackoverflow.com/questions/35931946/basic-example-for-sharing-text-or-image-with-uiactivityviewcontroller-in-swift
        let shareController = UIActivityViewController(activityItems: [card.card], applicationActivities: nil)
        shareController.popoverPresentationController?.sourceView = self.view
        self.present(shareController, animated: true, completion: nil)
        
        // https://stackoverflow.com/questions/1134289/cocoa-core-data-efficient-way-to-count-entities
        // Print Count of Cards Saved
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
