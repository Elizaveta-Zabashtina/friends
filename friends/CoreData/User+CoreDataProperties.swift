import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var age: NSObject?
    @NSManaged public var photo: NSSet?
    @NSManaged public var offer: Offer?
    @NSManaged public var dialog: NSSet?

}

// MARK: Generated accessors for photo
extension User {

    @objc(addPhotoObject:)
    @NSManaged public func addToPhoto(_ value: Photo)

    @objc(removePhotoObject:)
    @NSManaged public func removeFromPhoto(_ value: Photo)

    @objc(addPhoto:)
    @NSManaged public func addToPhoto(_ values: NSSet)

    @objc(removePhoto:)
    @NSManaged public func removeFromPhoto(_ values: NSSet)

}

// MARK: Generated accessors for dialog
extension User {

    @objc(addDialogObject:)
    @NSManaged public func addToDialog(_ value: Dialog)

    @objc(removeDialogObject:)
    @NSManaged public func removeFromDialog(_ value: Dialog)

    @objc(addDialog:)
    @NSManaged public func addToDialog(_ values: NSSet)

    @objc(removeDialog:)
    @NSManaged public func removeFromDialog(_ values: NSSet)

}

extension User : Identifiable {

}
