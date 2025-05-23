//
//  MOHeroLocation+CoreDataClass.swift
//  GokuYColegas
//
//  Created by Javier Gomez on 9/4/25.
//
//

import Foundation
import CoreData

@objc(MOHeroLocation)
public class MOHeroLocation: NSManagedObject {

}

extension MOHeroLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MOHeroLocation> {
        return NSFetchRequest<MOHeroLocation>(entityName: "HeroLocation")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var date: String?
    @NSManaged public var hero: MOHero?

}

extension MOHeroLocation : Identifiable {

}

extension MOHeroLocation {
    func mapToHeroLocation() -> HeroLocation {
        HeroLocation(id: self.identifier ?? "",
                     longitude: self.longitude,
                     latitude: self.latitude,
                     date: self.date,
                     hero: self.hero?.mapToHero())
    }
}

