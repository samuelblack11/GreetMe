//
//  PriorCardsViewController.swift
//  GreetMe
//
//  Created by Sam Black on 3/31/22.
//

import Foundation
import UIKit


class PriorCardsViewController: UICollectionViewController {
// https://www.hackingwithswift.com/read/38/5/loading-core-data-objects-using-nsfetchrequest-and-nssortdescriptor
    var cards = [Card]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Did Load")
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! PriorCardCell

        let card = cards[(indexPath as NSIndexPath).row]
        cell.cardImage!.image = UIImage(data: card.card)
        cell.cardDetail!.text = "\(card.recipient) (\(card.occassion)) (\(card.date))"
        
        return cell
    }

}
