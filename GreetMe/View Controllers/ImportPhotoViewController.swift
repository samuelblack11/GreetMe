//
//  ImportPhotoViewController.swift
//  GreetMe
//
//  Created by Sam Black on 4/2/22.
//

import Foundation
import UIKit
import CoreData

class ImportPhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var photo1Button: UIButton!
    @IBOutlet weak var photo2Button: UIButton!
    @IBOutlet weak var photo3Button: UIButton!
    @IBOutlet weak var photo4Button: UIButton!
    var lastButtonPressed: Int = 0
    @IBOutlet weak var photo1Preview: UIImageView!
    @IBOutlet weak var photo2Preview: UIImageView!
    @IBOutlet weak var photo3Preview: UIImageView!
    @IBOutlet weak var photo4Preview: UIImageView!
    @IBOutlet weak var collage: UIStackView!
    var menu: UIMenu!
    

    @IBOutlet weak var navTitle: UINavigationItem!
        
    var barItems = [UIBarButtonItem]()

    
    // https://www.hackingwithswift.com/example-code/uikit/how-to-add-a-bar-button-to-a-navigation-bar
    let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(clickBackButton))

    let menuButton = UIBarButtonItem(barButtonSystemItem: .bookmarks , target: self, action: #selector(clickMenuButton))
    
    @objc func clickBackButton() {
        self.dismiss(animated: true, completion: nil)
    }
    

    
    @objc func clickMenuButton() {
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "MenuViewController") as UIViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func finalizePhotos() {
        self.performSegue(withIdentifier: "photoToNote", sender: nil)
    }
    
    
    // https://medium.nextlevelswift.com/creating-a-native-popup-menu-over-a-uibutton-or-uinavigationbar-645edf0329c4
    func createSubMenu() -> UIMenu {
        let photoLibraryItem =  UIAction(title: "Photo Library", image: UIImage(systemName: "photo.on.rectangle")) { (action) in
            self.selectPhoto()
       }
        
        let searchAPIForphotoItem = UIAction(title: "Search The Web", image: UIImage(systemName: "magnifyingglass")) { (action) in
            }
        
        let menu = UIMenu(title: "Choose a Photo Selection Method", options: .displayInline, children: [photoLibraryItem, searchAPIForphotoItem])
        return menu
    
    }
    
    
    
    func imageFill(imageView: UIImageView!) {
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        imageFill(imageView: photo1Preview)
        imageFill(imageView: photo2Preview)
        imageFill(imageView: photo3Preview)
        imageFill(imageView: photo4Preview)

        navTitle.leftBarButtonItems = [backButton, menuButton]
        navTitle.rightBarButtonItems = [menuButton]


    }
    
    @IBAction func selectPhoto1(_ sender: Any) {
        lastButtonPressed = 1
        menu = createSubMenu()
        photo1Button.menu = menu
        photo1Button.showsMenuAsPrimaryAction = true
    }
    
    @IBAction func selectPhoto2(_ sender: Any) {
        lastButtonPressed = 2
        menu = createSubMenu()
        photo2Button.menu = menu
        photo2Button.showsMenuAsPrimaryAction = true
    }
    
    @IBAction func selectPhoto3(_ sender: Any) {
        lastButtonPressed = 3
        photo3Button.menu = menu
        photo3Button.showsMenuAsPrimaryAction = true
    }
    
    @IBAction func selectPhoto4(_ sender: Any) {
        lastButtonPressed = 4
        photo4Button.menu = menu
        photo4Button.showsMenuAsPrimaryAction = true
    }
    
    // https://www.hackingwithswift.com/read/1/5/loading-images-with-uiimage
    // Select Photo using UIImagePickerController
    // imageView will assign photo to specified Image Preview imageView
    func selectPhoto() {
        let selectPhoto = UIImagePickerController()
        selectPhoto.delegate = self
        selectPhoto.sourceType = .photoLibrary
        present(selectPhoto, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    @IBAction func testPhotoAPI(_ sender: Any) {
        PhotoAPI.getPhoto(randomSearch: "Baklava")
    }
    
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            
            // if "Select Photo 1 Pressed"
            if lastButtonPressed == 1 {
            photo1Preview.image = image
            imageFill(imageView: photo1Preview)
            }
            
            if lastButtonPressed == 2 {
            photo2Preview.image = image
            imageFill(imageView: photo2Preview)
            }
            
            if lastButtonPressed == 3 {
            photo3Preview.image = image
            imageFill(imageView: photo3Preview)
            }

            if lastButtonPressed == 4 {
            photo4Preview.image = image
            imageFill(imageView: photo4Preview)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    // https://www.hackingwithswift.com/example-code/system/how-to-pass-data-between-two-view-controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoToNote" {            
            // https://www.hackingwithswift.com/example-code/media/how-to-render-a-uiview-to-a-uiimage
            // Convert stack view (UIView) to image (UIImage)
            let renderer = UIGraphicsImageRenderer(size: collage.bounds.size)
            let collageImage = renderer.image { ctx in
                collage.drawHierarchy(in: collage.bounds, afterScreenUpdates: true)
            }
            
            let controller = segue.destination as! WriteNoteViewController
            controller.collageImage = (collageImage.pngData())!
        
            }
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
