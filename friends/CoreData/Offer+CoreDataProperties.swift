//
//  Offer+CoreDataProperties.swift
//  friends
//
//  Created by Елизавета Забаштина on 09.11.2022.
//
//

import Foundation
import CoreData


extension Offer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Offer> {
        return NSFetchRequest<Offer>(entityName: "Offer")
    }

    @NSManaged public var id: Int64
    @NSManaged public var text: String?
    @NSManaged public var user: User?

}

extension Offer : Identifiable {

}
