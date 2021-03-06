//
//  ImportPhotoViewController.swift
//  GreetMe
//
//  Created by Sam Black on 4/2/22.
//

import Foundation
import UIKit
import CoreData
import Network
import SystemConfiguration

class ImportPhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UISearchBarDelegate {
    
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
    @IBOutlet weak var userSearch: UISearchBar!
    var searchText: String!
    var searchBarText: String!
    //var chosenUnsplashImage: UIImage!

    @IBOutlet weak var attribution1: UITextView!
    @IBOutlet weak var attribution2: UITextView!
    @IBOutlet weak var attribution3: UITextView!
    @IBOutlet weak var attribution4: UITextView!
    
    
    // https://www.hackingwithswift.com/read/7/3/parsing-json-using-the-codable-protocol
    var unsplashPhotos: [ResultDetails]!
    var appDelegate: AppDelegate {
     return UIApplication.shared.delegate as! AppDelegate
    }
    var unsplashSmallPhotoURLs: [String] = [""]
    
    @IBAction func finalizePhotos() {
        savePhotosToAppDelegate()
        appDelegate.lastPhotoButtonPressed = lastButtonPressed
        self.performSegue(withIdentifier: "photoToNote", sender: nil)
    }
    
    // https://www.hackingwithswift.com/example-code/networking/how-to-check-for-internet-connectivity-using-nwpathmonitor
    func connectedToInternet() -> Bool {
        var connected = false
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            print("***********")
            print(path.status)
            if path.status == .satisfied {
                print("Set Connected = True")
                connected = true  // online
                //return connected
                print("Connected Status in Closure.....")
                print(connected)
            }
        }
        print("Now Outisde Closure.........")
        print(monitor)
        print(connected)

        print("Return value for Connected: \(connected)")
        return connected
    }
    
    

    // https://medium.nextlevelswift.com/creating-a-native-popup-menu-over-a-uibutton-or-uinavigationbar-645edf0329c4
    func createSubMenu() -> UIMenu {
        
        let photoLibraryItem =  UIAction(title: "Photo Library", image: UIImage(systemName: "photo.on.rectangle")) { (action) in
            self.selectPhoto()
       }
        var searchForPhotoAPI: UIAction!
        if connectedToInternet() {
            print("Set Search for Photo API ENABLED")
            searchForPhotoAPI = UIAction(title: "Search The Web", image: UIImage(systemName: "magnifyingglass")) { (action) in
                        self.savePhotosToAppDelegate()
                        self.userSearch.isHidden = false
            }
        }
        else {
            print("Set Search for Photo API DISABLED")
            searchForPhotoAPI = UIAction(title: "Search The Web", image: UIImage(systemName: "magnifyingglass"),attributes: .disabled) { (action) in
                        self.savePhotosToAppDelegate()
                        self.userSearch.isHidden = false
            }
        }
    
        let menu =  UIMenu(title: "Choose a Photo Selection Method", options: .displayInline, children: [photoLibraryItem, searchForPhotoAPI])
        return menu
    }
    
    func savePhotosToAppDelegate() {
        self.appDelegate.photo1 = self.photo1Preview.image!
        self.appDelegate.photo2 = self.photo2Preview.image!
        self.appDelegate.photo3 = self.photo3Preview.image!
        self.appDelegate.photo4 = self.photo4Preview.image!
    }
    
    // https://guides.codepath.com/ios/Search-Bar-Guide
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.isHidden = false
            if searchBar.text != nil {
                searchBarText = searchBar.text?.replacingOccurrences(of: " ", with: "-")
                searchText = searchBarText
                performSegue(withIdentifier: "importToUnsplash", sender: nil)
            }
            
            else if searchBar.text == nil {
                sendAlert(title: "Please Type a Value To Search", message: "this field is required in order to search")
            }
        }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
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
        userSearch.delegate = self
        userSearch.isHidden = true
        
    }
    
    
    func addAttribution(textView: UITextView) {
        let text =  NSMutableAttributedString(string: "Photo by \(appDelegate.chosenPhotographerName!) on Unsplash")
        text.addAttribute(.link, value: "https://unsplash.com/@\(appDelegate.chosenPhotographerUserName!)" , range: NSRange(location: 9, length: appDelegate.chosenPhotographerName!.count))
        text.addAttribute(.link, value: "https://unsplash.com" , range: NSRange(location: 13 + appDelegate.chosenPhotographerName!.count, length: 8))
        textView.attributedText = text
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.photo1Preview.image =  self.appDelegate.photo1
        self.photo2Preview.image =  self.appDelegate.photo2
        self.photo3Preview.image =  self.appDelegate.photo3
        self.photo4Preview.image =  self.appDelegate.photo4
        
        imageFill(imageView: photo1Preview)
        imageFill(imageView: photo2Preview)
        imageFill(imageView: photo3Preview)
        imageFill(imageView: photo4Preview)
        
        if appDelegate.chosenUnsplashImage != nil {

            if appDelegate.lastPhotoButtonPressed!  == 1 {
                photo1Preview.image = appDelegate.chosenUnsplashImage!
                addAttribution(textView: attribution1)
                appDelegate.attribution1 = attribution1

            }
            else if appDelegate.lastPhotoButtonPressed!  == 2 {
                photo2Preview.image = appDelegate.chosenUnsplashImage!
                addAttribution(textView: attribution2)
                appDelegate.attribution2 = attribution2
            }
            else if appDelegate.lastPhotoButtonPressed!  == 3 {
                photo3Preview.image = appDelegate.chosenUnsplashImage!
                addAttribution(textView: attribution3)
                appDelegate.attribution3 = attribution3
            }
            else if appDelegate.lastPhotoButtonPressed!  == 4 {
                photo4Preview.image = appDelegate.chosenUnsplashImage!
                addAttribution(textView: attribution4)
                appDelegate.attribution4 = attribution4
            }
            
            appDelegate.lastPhotoButtonPressed = 0
            appDelegate.chosenUnsplashImage = nil
        }

        if appDelegate.attribution1 != nil {
            attribution1.attributedText = appDelegate.attribution1.attributedText
        }
        if appDelegate.attribution2 != nil {
            attribution2.attributedText = appDelegate.attribution2.attributedText
        }
        if appDelegate.attribution3 != nil {
            attribution3.attributedText = appDelegate.attribution3.attributedText
        }
        if appDelegate.attribution4 != nil {
            attribution4.attributedText = appDelegate.attribution4.attributedText
        }

        savePhotosToAppDelegate()
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
        menu = createSubMenu()
        photo3Button.menu = menu
        photo3Button.showsMenuAsPrimaryAction = true
    }
    
    @IBAction func selectPhoto4(_ sender: Any) {
        lastButtonPressed = 4
        menu = createSubMenu()
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            
            // if "Select Photo 1 Pressed"
            if lastButtonPressed == 1 {
            photo1Preview.image = image
            imageFill(imageView: photo1Preview)
            appDelegate.attribution1 = attribution1
            attribution1.text = ""
            }
            
            if lastButtonPressed == 2 {
            photo2Preview.image = image
            imageFill(imageView: photo2Preview)
            appDelegate.attribution2 = attribution2
            attribution2.text = ""

            }
            
            if lastButtonPressed == 3 {
            photo3Preview.image = image
            imageFill(imageView: photo3Preview)
            appDelegate.attribution3 = attribution3
            attribution3.text = ""
            }

            if lastButtonPressed == 4 {
            photo4Preview.image = image
            imageFill(imageView: photo4Preview)
            appDelegate.attribution4 = attribution4
            attribution4.text = ""
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    // https://www.hackingwithswift.com/example-code/system/how-to-pass-data-between-two-view-controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        appDelegate.lastPhotoButtonPressed = lastButtonPressed
        if segue.identifier == "photoToNote" {
            savePhotosToAppDelegate()
            // https://www.hackingwithswift.com/example-code/media/how-to-render-a-uiview-to-a-uiimage
            // Convert stack view (UIView) to image (UIImage)
            let renderer = UIGraphicsImageRenderer(size: collage.bounds.size)
            let collageImage = renderer.image { ctx in
                collage.drawHierarchy(in: collage.bounds, afterScreenUpdates: true)
            }
            
            let controller = segue.destination as! WriteNoteViewController
            controller.collageImage = (collageImage.pngData())!
        }
        if segue.identifier == "importToUnsplash" {
            savePhotosToAppDelegate()
            appDelegate.lastSegue = "importToUnsplash"
            let controller = segue.destination as! UnsplashCollectionViewController
            controller.searchText = searchText
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
extension ImportPhotoViewController {
    
    func sendAlert(title: String, message: String) {
    // https://stackoverflow.com/questions/24195310/how-to-add-an-action-to-a-uialertview-button-using-swift-ios
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default) {
                UIAlertAction in NSLog("Dismiss Pressed")
            self.navigationController?.popViewController(animated: true)
        }
            
        alertController.addAction(dismissAction)
        self.present(alertController,animated: true, completion: nil)
    }
    
}
