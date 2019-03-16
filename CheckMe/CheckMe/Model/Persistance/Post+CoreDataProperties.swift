//
//  Post+CoreDataProperties.swift
//  
//
//  Created by Vadzim Sasnouski on 3/14/19.
//
//

import Foundation
import CoreData

extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var name: String?
    @NSManaged public var desciption: String?
    @NSManaged public var category: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var user: User?

}
