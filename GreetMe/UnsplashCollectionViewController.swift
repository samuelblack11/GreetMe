//
//  UnsplashPicker.swift
//  GreetMe
//
//  Created by Sam Black on 4/17/22.
//

import Foundation
import UIKit
import Network
//import UnsplashPhotoPicker


class UnsplashCollectionViewController: UICollectionViewController {
    
    @IBOutlet var unsplashCollectionView: UICollectionView!
    var unsplashSmallPhotoURLs: [String] = []
    var unsplashSmallPhotos: [UIImage] = []
    var unsplashuserNames: [String] = []
    var unsplashNames: [String] = []
    var unsplashDownloadLocations: [String] = []
    var searchText: String!
    var picCount: Int!
    var chosenImage: UIImage!
    var chosenPhotographerUserName: String!
    var chosenPhotographerName: String!
    var chosenDownloadLocation: String!

    weak var UnsplashCell: UnsplashCell?
    
    var appDelegate: AppDelegate {
     return UIApplication.shared.delegate as! AppDelegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UnsplashCell?.activityIndicator.isHidden = true
        getUnsplashPhotos()
        debugPrint("viewDidLoad Called...")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        debugPrint("viewWillAppear Called...")
        super.viewWillAppear(true)
    }
    
    func getUnsplashPhotos() {
        self.spinIndicator(true)
        PhotoAPI.getPhoto(userSearch: searchText, completionHandler: { (response, error) in
            if response != nil {
                self.picCount = response!.count
                DispatchQueue.main.async {
                for picture in response! {
                    if picture.urls.small != nil && picture.user.username != nil && picture.user.name != nil && picture.links.download_location != nil {
                        debugPrint("Picture Object......")
                        debugPrint(picture)
                        let thisPicture = picture.urls.small
                        self.unsplashSmallPhotoURLs.append(thisPicture!)
                        self.unsplashuserNames.append(picture.user.username!)
                        self.unsplashNames.append(picture.user.name!)
                        self.unsplashDownloadLocations.append(picture.links.download_location!)
                    }}

                }
            }
            if self.picCount == 0 {
                UnsplashCollectionViewController().sendAlert(title: "No Results for your Search", message: "Please search for something else.")
            }
            if response == nil {
                self.spinIndicator(true)
                UnsplashCollectionViewController().sendAlert(title: "Unable to Connect to Internet", message: "Please try again later.")
            }
            self.loadUnsplashPhotos()
            self.spinIndicator(false)
        })
    }

    func loadUnsplashPhotos() {
        //unsplashCollectionView.reloadData()
        DispatchQueue.main.async {
        self.collectionView.reloadData()
        }
    }
    
    //https://samwize.com/2015/11/30/understanding-uicollection-flow-layout/
    func setLayout() {
        debugPrint("setLayout() called")
        super.viewDidLayoutSubviews()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 155, height: 155)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.headerReferenceSize = CGSize(width: 0, height: 10)
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UnsplashCell", for: indexPath) as! UnsplashCell
        self.spinIndicator(true)
        // https://www.hackingwithswift.com/example-code/calayer/how-to-add-a-border-outline-color-to-a-uiview
        cell.layer.borderColor = UIColor.systemBlue.cgColor
        cell.layer.borderWidth = 0.5
        //let image = unsplashSmallPhotos[(indexPath as NSIndexPath).row]
        let imageString = unsplashSmallPhotoURLs[(indexPath as NSIndexPath).row]
        DispatchQueue.main.async {

            let imageURL = URL(string: imageString)
            let thisPhotoData = try? Data(contentsOf: imageURL!)
            let image = UIImage(data: thisPhotoData!)!
            self.unsplashSmallPhotos.append(image)
            cell.unsplashImage.image = image
            cell.unsplashImage.contentMode = UIView.ContentMode.scaleAspectFill
            cell.layer.backgroundColor = UIColor.black.cgColor
        }
        self.spinIndicator(false)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        chosenImage = unsplashSmallPhotos[(indexPath as NSIndexPath).row]
        chosenPhotographerUserName = unsplashuserNames[(indexPath as NSIndexPath).row]
        chosenPhotographerName = unsplashNames[(indexPath as NSIndexPath).row]
        chosenDownloadLocation = unsplashDownloadLocations[(indexPath as NSIndexPath).row]
        
        // create Get request to notify Unsplash photo was downloaded
        PhotoAPI.pingDownloadURL(downloadLocation: chosenDownloadLocation, completionHandler: { (response, error) in
            if response != nil {
                debugPrint("Ping Success!.......")
                debugPrint(response)
            }
            if response == nil {
                debugPrint("Ping Failed!.......")
                debugPrint(response)
            }
        })
        self.performSegue(withIdentifier: "unsplashToImport", sender: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        unsplashSmallPhotoURLs.count
        }
      
    // https://www.hackingwithswift.com/example-code/system/how-to-pass-data-between-two-view-controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "unsplashToImport" {
            appDelegate.lastSegue  = "unsplashToImport"
            let controller = segue.destination as! ImportPhotoViewController
            //controller.chosenUnsplashImage = chosenImage
            appDelegate.chosenUnsplashImage = chosenImage
            appDelegate.chosenPhotographerUserName = chosenPhotographerUserName
            appDelegate.chosenPhotographerName = chosenPhotographerName
            
            }
    }
    
    func spinIndicator(_ gettingPhotos: Bool) {
        if gettingPhotos {
            self.UnsplashCell?.activityIndicator.isHidden = false
            self.UnsplashCell?.activityIndicator.startAnimating()
            }
        else {
            self.UnsplashCell?.activityIndicator.stopAnimating()
            self.UnsplashCell?.activityIndicator.isHidden = true
            }
    }
    
}

extension UnsplashCollectionViewController {
    
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
