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
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UnsplashCell", for: indexPath) as! UnsplashCell
        
        print("# of SmallPhotos Successfully Read in from appDelegate \(appDelegate.unsplashSmallPhotoURLs.count)")

        let unsplashImageURL = appDelegate.unsplashSmallPhotoURLs[(indexPath as NSIndexPath).row]
        print(unsplashImageURL)
        let imageURL = URL(string: unsplashImageURL)
        print(imageURL)
        let thisPhotoData = try? Data(contentsOf: imageURL!)
        print(thisPhotoData)
        let unsplashImage = UIImage(data: thisPhotoData!)!
        print(unsplashImage)
        cell.unsplashImage.image = unsplashImage
                
       return cell
    }
    

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("test")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    
}
