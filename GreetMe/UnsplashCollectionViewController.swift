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

    // appDelegate.unsplashSmallPhotoURLs
    
    var appDelegate: AppDelegate {
     return UIApplication.shared.delegate as! AppDelegate
    }
    
    
    override func viewDidLoad() {
        //loadUnsplashPhotos()
        super.viewDidLoad()
        print("viewDidLoad Called...")
    }
    
    
    func loadUnsplashPhotos() {

        unsplashCollectionView.reloadData()
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
        
        //print("# of SmallPhotos Successfully Read in from appDelegate \(appDelegate.unsplashSmallPhotoURLs.count)")
        print("# of SmallPhotos Successfully Read in from List of Photos \(self.unsplashSmallPhotos.count)")
        
        PhotoAPI.getPhoto(userSearch: searchText, completionHandler: { (response, error) in
            if response != nil {
                print(self.searchText)
                print("# of Elements in Response:.....")
                //print(response?.count)
                print((response!.count))
                self.picCount = response!.count
                //DispatchQueue.main.async {
                    if response![(indexPath as NSIndexPath).row].urls.small != nil {
                        var thisPicture = response![(indexPath as NSIndexPath).row].urls.small
                        let imageURL = URL(string: thisPicture!)
                        print(imageURL)
                        let thisPhotoData = try? Data(contentsOf: imageURL!)
                        print(thisPhotoData)
                        let unsplashImage = UIImage(data: thisPhotoData!)!
                        cell.unsplashImage.image = unsplashImage
                    }
                //}
                self.collectionView.reloadData()
            }
        })
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("test")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(picCount)
        //picCount
        10
    }
}
