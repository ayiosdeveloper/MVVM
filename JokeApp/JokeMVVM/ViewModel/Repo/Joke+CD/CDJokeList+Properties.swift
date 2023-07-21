//
//  CDJokeList+Properties.swift
//  JokeApp
//
//  Created by Ankit Yadav on 14/06/23.
//

import Foundation
import CoreData

extension CDJokeList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDJokeList> {
        return NSFetchRequest<CDJokeList>(entityName: "CDJokeList")
    }

    @NSManaged public var joke: String?
    @NSManaged public var id: UUID?
}
