//
//  Dialog+CoreDataProperties.swift
//  friends
//
//  Created by Елизавета Забаштина on 09.11.2022.
//
//

import Foundation
import CoreData


extension Dialog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dialog> {
        return NSFetchRequest<Dialog>(entityName: "Dialog")
    }

    @NSManaged public var id: Int64
    @NSManaged public var dialog_time: Date?
    @NSManaged public var user: NSSet?
    @NSManaged public var message: NSSet?

}

// MARK: Generated accessors for user
extension Dialog {

    @objc(addUserObject:)
    @NSManaged public func addToUser(_ value: User)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUser(_ value: User)

    @objc(addUser:)
    @NSManaged public func addToUser(_ values: NSSet)

    @objc(removeUser:)
    @NSManaged public func removeFromUser(_ values: NSSet)

}

// MARK: Generated accessors for message
extension Dialog {

    @objc(addMessageObject:)
    @NSManaged public func addToMessage(_ value: Message)

    @objc(removeMessageObject:)
    @NSManaged public func removeFromMessage(_ value: Message)

    @objc(addMessage:)
    @NSManaged public func addToMessage(_ values: NSSet)

    @objc(removeMessage:)
    @NSManaged public func removeFromMessage(_ values: NSSet)

}

extension Dialog : Identifiable {

}
