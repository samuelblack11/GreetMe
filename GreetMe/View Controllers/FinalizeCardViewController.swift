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

// for future consideration: https://developer.apple.com/forums/thread/678394

class FinalizeCardViewController: UIViewController {
    
    var card: Card!
    var date: Date!
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
    var noteViewImage: UIImage!
    var cardExport: Data!
    public var documentData: Data?
    var appDelegate: AppDelegate {
     return UIApplication.shared.delegate as! AppDelegate
    }

    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBOutlet weak var menuButton: UIButton!
    
    
    
    
    func determineCardSource() {
        
        // If just created a new card
        if appDelegate.lastSegue == "writeNoteToFinalize" {
            saveButton.isEnabled = true
            collageView.image = UIImage(data: collageImage!)
            noteView.text = noteText!
            noteView.font = noteFont!
            // collageImage set from prepare segue in WriteNoteViewController
            // name set from prepare segue in WriteNoteViewController
            // occassion set from prepare segue in WriteNoteViewController
            // Date set below in saveToCoreDate() function
            
        }
        
        // If reading data from PriorViewController
       else if appDelegate.lastSegue == "priorToFinalize" {
           saveButton.isEnabled = false
           collageImage = card.collage
           collageView.image = UIImage(data: collageImage!)
           name = card.recipient
           occassion = card.occassion
           date = card.date
           
           do {
               if let noteObject = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(card.message) as? UITextView {
               noteView.text = noteObject.text
               noteView.font = noteObject.font
               }
           }
            catch {
                   print("Error")
               }
        }
    }
    
    override func viewDidLoad() {
        print("viewDidLoad Called")
        super.viewDidLoad()
        determineCardSource()
        imageFill(imageView: collageView)
        //determineRecipient()

        }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear Called")
        determineCardSource()
    }
        
    func imageFill(imageView: UIImageView!) {
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
    }
    
    @IBAction func saveAction(_ sender: Any) {
        saveToCoreData()
    }
    
    
    @objc func saveToCoreData() {
        // Create Core Data Object
        let card = Card(context: DataController.shared.viewContext)
        // https://www.hackingwithswift.com/example-code/system/how-to-save-and-load-objects-with-nskeyedarchiver-and-nskeyedunarchiver
        do {
            card.card = try NSKeyedArchiver.archivedData(withRootObject: cardStack!, requiringSecureCoding: false)
            card.message = try NSKeyedArchiver.archivedData(withRootObject: noteView!, requiringSecureCoding: false)

            print("Saved cardStack as Stack View")
        }
        catch {
            print("Couldn't save cardStack")
        }
        
        card.collage = collageImage!
        card.recipient = name!
        card.occassion = occassion!
        card.date = Date.now
        self.saveContext()
        debugPrint("Context Saved")

        // https://stackoverflow.com/questions/1134289/cocoa-core-data-efficient-way-to-count-entities
        // Print Count of Cards Saved
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
        let count = try! DataController.shared.viewContext.count(for: fetchRequest)
        print("\(count) Cards Saved")        
    }
    
    @IBAction func shareAction(_ sender: Any) {
        cardExport = prepCardForExport()
        // https://stackoverflow.com/questions/35931946/basic-example-for-sharing-text-or-image-with-uiactivityviewcontroller-in-swift
        let shareController = UIActivityViewController(activityItems: [cardExport!], applicationActivities: nil)
        shareController.popoverPresentationController?.sourceView = self.view
        self.present(shareController, animated: true, completion: nil)
    }
    
    func prepCardForExport() -> Data {
        
        // https://www.advancedswift.com/resize-uiimage-no-stretching-swift/
        let imageRect_w = 350
        let imageRect_h = 325
        let imageRect_dy = CGFloat(30)
        let pageRect_X_offset = CGFloat(15)
        let imageRect_dx = CGFloat(imageRect_w/3)
        let pageRect_Y_offset = CGFloat(imageRect_h + Int(imageRect_dy) + 30)
        
        
        let a4_width = 595.2 - 20
        let a4_height = 841.8
        //let us_letter_width = 612
        //let us_letter_height = 792
        let note_height = a4_height

        let imageRect = CGRect(x: 0, y: 0, width: imageRect_w , height: imageRect_h)
        let image = UIImage(data: collageImage!)!

        // https://www.hackingwithswift.com/example-code/uikit/how-to-render-pdfs-using-uigraphicspdfrenderer
        let pageRect = CGRect(x: 0, y: 0, width: a4_width, height: note_height)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)
        let textAttributes = [NSAttributedString.Key.font: noteView.font]
        let formattedText = NSAttributedString(string: noteView.text, attributes: textAttributes as [NSAttributedString.Key : Any])
        
        let data = renderer.pdfData(actions: {ctx in ctx.beginPage()
            // Append formattedText to collageView
                //.insetBy(dx: 50, dy: 50)
            // https://www.hackingwithswift.com/articles/103/seven-useful-methods-from-cgrect
            image.draw(in: imageRect.offsetBy(dx: imageRect_dx, dy: imageRect_dy))
            formattedText.draw(in: pageRect.offsetBy(dx: pageRect_X_offset, dy: pageRect_Y_offset))
        })
        return data
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
    
    
    
    
    @IBAction func clickMenuButton(_ sender: Any) {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as UIViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    
    // https://developer.apple.com/documentation/contacts
    func determineRecipient() {
        print("Determining Recipient")
        // Fetch contacts that have the name entered by the user on the WriteNoteViewController
        let store = CNContactStore()
        do {
            let predicate = CNContact.predicateForContacts(matchingName: name)
            // let predicate = CNContact.predicateForContacts(matchingName: card.recipient)

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
}
