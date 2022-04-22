//
//  UnsplashPicker.swift
//  GreetMe
//
//  Created by Sam Black on 4/17/22.
//

import Foundation
import UIKit
//import UnsplashPhotoPicker


class UnsplashCollectionViewController: UICollectionViewController {
    
    @IBOutlet var unsplashCollectionView: UICollectionView!
    var unsplashSmallPhotoURLs: [String]!
    var unsplashSmallPhotos: [UIImage] = []
    var searchText: String!
    var picCount: Int!
    var chosenImage: UIImage!
    
    var appDelegate: AppDelegate {
     return UIApplication.shared.delegate as! AppDelegate
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUnsplashPhotos()
        print("viewDidLoad Called...")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear Called...")
    }
    
    
    func getUnsplashPhotos() {
        PhotoAPI.getPhoto(userSearch: searchText, completionHandler: { (response, error) in
            if response != nil {
                print(self.searchText!)
                print("# of Elements in Response:.....")
                self.picCount = response!.count
                for picture in response! {
                    if picture.urls.small != nil {
                        let thisPicture = picture.urls.small
                        let imageURL = URL(string: thisPicture!)
                        let thisPhotoData = try? Data(contentsOf: imageURL!)
                        let unsplashImage = UIImage(data: thisPhotoData!)!
                        self.unsplashSmallPhotos.append(unsplashImage)
                    }}}
            self.loadUnsplashPhotos()
        })}

    func loadUnsplashPhotos() {
        unsplashCollectionView.reloadData()
        DispatchQueue.main.async {
        self.collectionView.reloadData()
        }
    }
    
    //https://samwize.com/2015/11/30/understanding-uicollection-flow-layout/
    func setLayout() {
        print("setLayout() called")
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
        // https://www.hackingwithswift.com/example-code/calayer/how-to-add-a-border-outline-color-to-a-uiview
        cell.layer.borderColor = UIColor.systemBlue.cgColor
        cell.layer.borderWidth = 0.5
        
        let image = unsplashSmallPhotos[(indexPath as NSIndexPath).row]
        cell.unsplashImage.image = image
        cell.unsplashImage.contentMode = UIView.ContentMode.scaleAspectFill

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        chosenImage = unsplashSmallPhotos[(indexPath as NSIndexPath).row]
        self.performSegue(withIdentifier: "unsplashToImport", sender: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        unsplashSmallPhotos.count
        }
    
    
    
    // https://www.hackingwithswift.com/example-code/system/how-to-pass-data-between-two-view-controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "unsplashToImport" {
            appDelegate.lastSegue  = "unsplashToImport"
            let controller = segue.destination as! ImportPhotoViewController
            print("controller.searchText = searchText")
            controller.chosenUnsplashImage = chosenImage
            appDelegate.chosenUnsplashImage = chosenImage
            }
    }
    
    }
