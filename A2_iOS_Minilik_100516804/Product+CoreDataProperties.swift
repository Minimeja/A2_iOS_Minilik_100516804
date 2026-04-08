//
//  Product+CoreDataProperties.swift
//  A2_iOS_Minilik_100516804
//
//  Created by Minilik Meja on 2026-04-06.
//
//

public import Foundation
public import CoreData


public typealias ProductCoreDataPropertiesSet = NSSet

extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var productDescription: String?
    @NSManaged public var productID: String?
    @NSManaged public var productName: String?
    @NSManaged public var productPrice: Double
    @NSManaged public var productProvider: String?

}

extension Product : Identifiable {

}
