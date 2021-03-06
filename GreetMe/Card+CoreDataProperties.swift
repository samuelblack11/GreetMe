//
//  Card+CoreDataProperties.swift
//  GreetMe
//
//  Created by Sam Black on 4/9/22.
//
//

// https://www.hackingwithswift.com/read/38/4/creating-an-nsmanagedobject-subclass-with-xcode
import Foundation
import CoreData


extension Card {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var card: Data
    @NSManaged public var collage: Data
    @NSManaged public var message: Data

    @NSManaged public var occassion: String
    @NSManaged public var recipient: String
    @NSManaged public var date: Date


}

extension Card : Identifiable {

}
