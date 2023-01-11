//
//  Message+CoreDataProperties.swift
//  friends
//
//  Created by Елизавета Забаштина on 09.11.2022.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var id: Int64
    @NSManaged public var text: String?
    @NSManaged public var messageIsRead: Bool
    @NSManaged public var messageTime: Date?
    @NSManaged public var dialog: Dialog?

}

extension Message : Identifiable {

}
