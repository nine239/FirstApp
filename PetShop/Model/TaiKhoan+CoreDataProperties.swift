//
//  TaiKhoan+CoreDataProperties.swift
//  PetShop
//
//  Created by Nguyen Tuan Vinh on 13/8/24.
//
//

import Foundation
import CoreData


extension TaiKhoan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaiKhoan> {
        return NSFetchRequest<TaiKhoan>(entityName: "TaiKhoan")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var fullname: String?
    @NSManaged public var email: String?

}

extension TaiKhoan : Identifiable {

}
