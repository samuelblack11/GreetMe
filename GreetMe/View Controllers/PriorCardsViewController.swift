//
//  PriorCardsViewController.swift
//  GreetMe
//
//  Created by Sam Black on 3/31/22.
//

import Foundation
import UIKit
import CoreData


class PriorCardsViewController: UICollectionViewController {
// https://www.hackingwithswift.com/read/38/5/loading-core-data-objects-using-nsfetchrequest-and-nssortdescriptor
    var cards = [Card]()

    //https://samwize.com/2015/11/30/understanding-uicollection-flow-layout/
    func setLayout() {
        print("setLayout() called")
        super.viewDidLayoutSubviews()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 175, height: 370)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.headerReferenceSize = CGSize(width: 0, height: 25)
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionView.collectionViewLayout = layout
    }
    
    
    
    func loadCoreData() {
        let request = Card.createFetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]
        do {
            cards = try DataController.shared.container.viewContext.fetch(request)
            print("Got \(cards.count) Cards")
            collectionView.reloadData()
        }
        catch {
            print("Fetch failed")
        }
    }
    
    func deleteCoreData() {
        // https://cocoacasts.com/how-to-delete-every-record-of-a-core-data-entity
        let request = Card.createFetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sort]
        do {
            cards = try DataController.shared.container.viewContext.fetch(request)
            for card in cards {
                DataController.shared.viewContext.delete(card)
            }
            // Save Changes
            try DataController.shared.viewContext.save()

        } catch {
            // Error Handling
            // ...
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Did Load")
        setLayout()
        //deleteCoreData()
        loadCoreData()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! PriorCardCell
        
        // https://www.hackingwithswift.com/example-code/calayer/how-to-add-a-border-outline-color-to-a-uiview
        cell.layer.borderColor = UIColor.systemBlue.cgColor
        cell.layer.borderWidth = 0.5

        let card = cards[(indexPath as NSIndexPath).row]
        cell.cardImage!.image = UIImage(data: card.card)
        
        // https://cocoacasts.com/swift-fundamentals-how-to-convert-a-date-to-a-string-in-swift
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyy"
        print(card.date)
        let card_date_string = dateFormatter.string(from: card.date)
        print(card_date_string)
        cell.cardDetail!.text = "\(card.recipient) (\(card.occassion)) (\(card_date_string))"
        cell.cardDetail!.font = .boldSystemFont(ofSize: 14)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //View In Detail
    }
}
