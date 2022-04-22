//
//  PriorCardsViewController.swift
//  GreetMe
//
//  Created by Sam Black on 3/31/22.
//

import Foundation
import UIKit
import CoreData


class PriorCardsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
// https://www.hackingwithswift.com/read/38/5/loading-core-data-objects-using-nsfetchrequest-and-nssortdescriptor
    var cards = [Card]()
    var card: Card!
    var menu: UIMenu!
    var chosenCollage: UIImageView!
    var chosenNoteField: UITextView!
    var appDelegate: AppDelegate {
     return UIApplication.shared.delegate as! AppDelegate
    }
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayoutFromStoryboard: UICollectionViewFlowLayout!

    //https://samwize.com/2015/11/30/understanding-uicollection-flow-layout/
    func setLayout() {
        print("setLayout() called")
        super.viewDidLayoutSubviews()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 375)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.headerReferenceSize = CGSize(width: 0, height: 10)
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
        //collectionView.collectionViewLayout = layout
        //collectionView.backgroundColor = .green
        //collectionViewLayoutFromStoryboard = layout
    }
    
    // https://stackoverflow.com/questions/38025112/how-do-i-set-collection-views-cell-size-via-the-auto-layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let cellsAcross: CGFloat = 2
        //let spaceBetweenCells: CGFloat = 1
        //let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: 150, height: 375)
        
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
        collectionView.delegate = self
        collectionView.dataSource = self
        loadCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadCoreData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! PriorCardCell
        //cell.translatesAutoresizingMaskIntoConstraints = false
        // https://www.hackingwithswift.com/example-code/calayer/how-to-add-a-border-outline-color-to-a-uiview
        cell.layer.borderColor = UIColor.systemBlue.cgColor
        cell.layer.borderWidth = 0.5
        let card = cards[(indexPath as NSIndexPath).row]
        print("CARD ----")
        print(card)
        print("CARD ----")
        // https://www.hackingwithswift.com/example-code/system/how-to-save-and-load-objects-with-nskeyedarchiver-and-nskeyedunarchiver
        do {
            if let noteObject = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(card.message) as? UITextView {
                cell.messageView.text = noteObject.text
                cell.messageView.font = noteObject.font
            }
        }
        catch {
            print("error translating note field to messageView")
        }
        // https://cocoacasts.com/swift-fundamentals-how-to-convert-a-date-to-a-string-in-swift
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyy"
        let card_date_string = dateFormatter.string(from: card.date)
        cell.collageView.image = UIImage(data: card.collage)
        cell.cardDetail!.text = "\(card.recipient) (\(card.occassion)) (\(card_date_string))"
        cell.cardDetail!.font = .boldSystemFont(ofSize: 14)
        
        return cell
    }
    

   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //View In Detail
        // if tap.....
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! PriorCardCell
        print("Did Select ItemAt")
        card = cards[(indexPath as NSIndexPath).row]
       
    }

    // https://developer.apple.com/documentation/uikit/uicontrol/adding_context_menus_in_your_app
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! PriorCardCell
        self.card = self.cards[(indexPath as NSIndexPath).row]
        print("display context menu")
        
            let enlargeGreeting =  UIAction(title: "Enlarge Greeting", image: UIImage(systemName: "plus.magnifyingglass")) { (action) in
            self.appDelegate.lastSegue = "priorToFinalize"
            self.performSegue(withIdentifier: "priorToFinalize", sender: nil)
       }
        
            // https://stackoverflow.com/questions/64714923/how-to-change-icon-color-in-uiaction-inside-uimenu/64727653
            let deleteGreeting = UIAction(title: "Delete Greeting", image: UIImage(systemName: "trash")?.withTintColor(.red, renderingMode: .alwaysOriginal)) { (action) in

            do {
                print("Attempting Delete")
                DataController.shared.viewContext.delete(self.card)
                try DataController.shared.viewContext.save()
                }
                // Save Changes
             catch {
                // Error Handling
                // ...
                 print("Couldn't Delete")
             }
            self.loadCoreData()
            }
            return UIMenu(title: "",children: [enlargeGreeting, deleteGreeting])

        }
    }
    
    
    // https://www.hackingwithswift.com/example-code/system/how-to-pass-data-between-two-view-controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "priorToFinalize" {
            let controller = segue.destination as! FinalizeCardViewController
            controller.card = card
            }
        }
}
