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
    
    var unsplashPhotos: PicResponse!
    @IBOutlet var unsplashCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        loadUnsplashPhotos()
        print("test")
    }
    
    
    func loadUnsplashPhotos() {
        //unsplashPhotos =
        unsplashCollectionView.reloadData()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unsplashCell", for: indexPath) as! UnsplashCell
        
        //let picture =
        
       return cell
    }
    

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("test")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    
}
