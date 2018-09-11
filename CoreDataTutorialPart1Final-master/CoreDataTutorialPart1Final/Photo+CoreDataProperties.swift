 //
 //  ViewController.swift
 //  Jsondatacoredata
 //
 //  Created by aravind-pt2199 on 11/09/18.
 //  Copyright © 2018 aravind-pt2199. All rights reserved.
 //
import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo");
    }

    @NSManaged public var author: String?
    @NSManaged public var tags: String?
    @NSManaged public var mediaURL: String?

}
