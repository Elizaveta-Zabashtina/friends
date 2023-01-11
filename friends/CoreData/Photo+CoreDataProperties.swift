//
//  Photo+CoreDataProperties.swift
//  friends
//
//  Created by Елизавета Забаштина on 09.11.2022.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var id: Int64
    @NSManaged public var image: NSObject?
    @NSManaged public var user: User?

}

extension Photo : Identifiable {

}
