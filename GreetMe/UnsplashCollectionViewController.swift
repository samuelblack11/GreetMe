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

    // appDelegate.unsplashSmallPhotoURLs
    
    var appDelegate: AppDelegate {
     return UIApplication.shared.delegate as! AppDelegate
    }
    
    
    override func viewDidLoad() {
        //loadUnsplashPhotos()
        super.viewDidLoad()
        loadUnsplashPhotos()
        print("viewDidLoad Called...")
    }
    
    
    func loadUnsplashPhotos() {
        // indexPath: IndexPath
        unsplashCollectionView.reloadData()
        DispatchQueue.main.async {
        self.collectionView.reloadData()
        }
        //DispatchQueue.main.async {
        //    self.collectionView.reloadItems(at: [indexPath])
        //}
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
        
        PhotoAPI.getPhoto(userSearch: searchText, completionHandler: { (response, error) in
            if response != nil {
                print(self.searchText!)
                print("# of Elements in Response:.....")
                //print(response?.count)
                print((response!.count))
                self.picCount = response!.count
                print(self.picCount!)
                //DispatchQueue.main.async {
                    if response![(indexPath as NSIndexPath).row].urls.small != nil {
                        var thisPicture = response![(indexPath as NSIndexPath).row].urls.small
                        let imageURL = URL(string: thisPicture!)
                        print(imageURL)
                        let thisPhotoData = try? Data(contentsOf: imageURL!)
                        print(thisPhotoData)
                        let unsplashImage = UIImage(data: thisPhotoData!)!
                        cell.unsplashImage.image = unsplashImage
                        cell.unsplashImage.contentMode = UIView.ContentMode.scaleAspectFill
                    }
            }
        })
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "unsplashToImport", sender: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            10
        }
    
    
    
    // https://www.hackingwithswift.com/example-code/system/how-to-pass-data-between-two-view-controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "unsplashToImport" {
            let controller = segue.destination as! ImportPhotoViewController
            print("controller.searchText = searchText")
            controller.chosenUnsplashImage = chosenImage
            }
    }
    
    }
