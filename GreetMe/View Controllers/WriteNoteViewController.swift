//
//  WriteNoteViewController.swift
//  GreetMe
//
//  Created by Sam Black on 4/2/22.
//

import Foundation
import UIKit
import SwiftUI

//     // https://codewithchris.com/uipickerview-example/


class WriteNoteViewController: UIViewController, UITextViewDelegate, UIFontPickerViewControllerDelegate {
 
    @IBOutlet weak var writeNoteField: UITextView!
    @IBOutlet weak var finalizeButton: UIButton!
    
    var collageImage: Data?
    var name: String!
    var occassion: String!
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var occasionField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.writeNoteField.delegate = self
        writeNoteField.text = "Write your message here :)"
        writeNoteField.textColor = UIColor.lightGray
        writeNoteField.font = writeNoteField.font?.withSize(18)
    }

    

    @IBAction func chooseFont(_ sender: Any) {
        callFontPicker()
    }
    
    func callFontPicker(){
        // https://www.hackingwithswift.com/example-code/uikit/how-to-let-users-choose-a-font-with-uifontpickerviewcontroller
        let configuration = UIFontPickerViewController.Configuration()
        configuration.includeFaces = true
        configuration.displayUsingSystemFont = true
        configuration.filteredTraits = [.classModernSerifs]
        let fontPicker = UIFontPickerViewController(configuration: configuration)
        fontPicker.delegate = self
        present(fontPicker, animated: true)
    }
    
    
    func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
        // attempt to read the selected font descriptor, but exit quietly if that fails
        guard let descriptor = viewController.selectedFontDescriptor else { return }
        let font = UIFont(descriptor: descriptor, size: 18)
        writeNoteField.font = font
    }
    
    func fontPickerViewControllerDidCancel(_ viewController: UIFontPickerViewController) {
        // This will automatically dismiss the font picker
        print("Did Cancel font picker View Controller")
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        writeNoteField.textColor = UIColor.black
    }
    

    
    // https://www.hackingwithswift.com/example-code/uikit/how-to-limit-the-number-of-characters-in-a-uitextfield-or-uitextview
    // Set Character Limit
    // Use this if you have a UITextView
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textView.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)

        // make sure the result is under 16 characters
        return updatedText.count <= 140
    }
    
    
    
    // https://www.hackingwithswift.com/example-code/system/how-to-pass-data-between-two-view-controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "writeNoteToFinalize" {
            // Convert stack view (UIView) to image (UIImage)
            let renderer = UIGraphicsImageRenderer(size: writeNoteField.bounds.size)
            let noteImage = renderer.image { ctx in
                view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
            }
            let controller = segue.destination as! FinalizeCardViewController
            controller.noteImage = (noteImage.pngData())!
            controller.collageImage = collageImage
            controller.name = nameField.text
            controller.occassion = occasionField.text

            }
        }
    
    
    @IBAction func writeNoteToFinalize(_ sender: Any) {
        performSegue(withIdentifier: "writeNoteToFinalize", sender: nil)
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
