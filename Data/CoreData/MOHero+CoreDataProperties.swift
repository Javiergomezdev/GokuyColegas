//
//  MOHero+CoreDataProperties.swift
//  GokuYColegas
//
//  Created by Javier Gomez on 9/4/25.
//
//

import Foundation
import CoreData


extension MOHero {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOHero> {
        return NSFetchRequest<MOHero>(entityName: "Hero")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var name: String?
    @NSManaged public var photo: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var locations: NSSet?

}

// MARK: Generated accessors for locations
extension MOHero {

    @objc(addLocationsObject:)
    @NSManaged public func addToLocations(_ value: MOHeroLocation)

    @objc(removeLocationsObject:)
    @NSManaged public func removeFromLocations(_ value: MOHeroLocation)

    @objc(addLocations:)
    @NSManaged public func addToLocations(_ values: NSSet)

    @objc(removeLocations:)
    @NSManaged public func removeFromLocations(_ values: NSSet)

}

extension MOHero : Identifiable {

}
