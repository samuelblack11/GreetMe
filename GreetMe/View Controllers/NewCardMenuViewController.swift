//
//  NewCardMenuViewController.swift
//  GreetMe
//
//  Created by Sam Black on 4/2/22.
//

import Foundation
import UIKit

class NewCardMenuViewController: UIViewController {
    
    @IBOutlet weak var createCollageButton: UIButton!
    @IBOutlet weak var createCustomVisualButton: UIButton!
    
    @IBOutlet weak var importImageView: UIImageView!
    
    @IBOutlet weak var createCustomVisualView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // searched camera
        imageFill(imageView: importImageView)
        // searched paint palette
        imageFill(imageView: createCustomVisualView)
        
        // searched envelopes
        // searched write
        
    }
    
    func imageFill(imageView: UIImageView!) {
        imageView.contentMode = UIView.ContentMode.scaleAspectFill    }
    
    
    @IBAction func createCustomVisualOnClick(_ sender: Any) {
    // https://stackoverflow.com/questions/24195310/how-to-add-an-action-to-a-uialertview-button-using-swift-ios
        let alertController = UIAlertController(title: "This Feature is Not Yet Available", message: "Please Try the Import Photos and Create Collage Button", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default) {
            UIAlertAction in NSLog("Dismiss Pressed")
        }
        
        alertController.addAction(dismissAction)
        self.present(alertController,animated: true, completion: nil)
        
    }
    
    
    @IBAction func createCollageSegue(_ sender: Any) {
        //performSegue(withIdentifier: "menuToPhoto", sender: nil)
        //self.view.window?.rootViewController?.presentedViewController!.dismiss(animated: true, completion: nil)
        //self.view.window?.rootViewController?.presentedViewController!.dismiss(animated: true, completion: nil)
        //self.view.window?.

        let controller = self.storyboard!.instantiateViewController(withIdentifier: "ImportPhotoViewController") as UIViewController
        self.present(controller, animated: true, completion: nil)
        
    }
    
    
}
