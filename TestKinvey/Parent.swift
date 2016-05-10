//
//  Parent.swift
//  VStar
//
//  Created by Edward LoPinto on 2/29/16.
//  Copyright © 2016 WPM Consulting Inc. All rights reserved.
//

import Foundation

/**
An object that conforms to `KCSPersistable` and encapsulates information from an entity in the
`Parents` collection on Kinvey.
*/
class Parent: NSObject {

    // MARK: - KCSPersistable properties

    /// The Kinvey object ID
    var entityId: String?  //required Kinvey property

    /// Metatdata such as last write time, creation time, etc.
    var metadata: KCSMetadata?  //optional Kinvey property

    // MARK: - StoreOptions

    /// The dictionary to pass to `KCSAppDataStore.storeWithOptions` to query the `Parents`
    /// collection
    static let defaultStoreOptions: [NSObject: AnyObject] = [
        KCSStoreKeyCollectionName: "Parents",
        KCSStoreKeyCollectionTemplateClass: Parent.self
    ]
    
    // Add properties for your entity here.

    // MARK: - ExtendedUserInfo properties

    /// The type of VStar user: either Parent or Coach
    let userType = VStarUserType.Parent

    /// The Kinvey user this `Parent` info belongs to.
    var user: KCSUser?

    /// The location of the `user`'s device.
    var currentLocation: CLLocation?

    // MARK: - Other properties

    /// An array of dictionaries representing this parent's children. Each dictionary includes the
    /// following keys: "firstName", "lastName", "grade", "favSports", and "gender".
    var children: NSArray?

    /// The address associated with the receiver's `user`.
    var addressString: String? {
        var fullAddress: String?

        if let coachAddress =
            user?.getValueForAttribute("address") as? [String: String] {

            if let street = coachAddress["street"], city = coachAddress["city"],
                state = coachAddress["state"], zip = coachAddress["zip"] {
                fullAddress = "\(street), \(city), \(state), \(zip)"
            }
        }

        return fullAddress
    }
    
    // MARK: - KCSPersistable methods
    
    /// Required method to map the receiver's properties to a Kinvey entity
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        let propertyMap = [
            "entityId": KCSEntityKeyId,
            "metadata": KCSEntityKeyMetadata,
            "user": "user",
            "children": "children",
            "currentLocation": KCSEntityKeyGeolocation
        ]
        
        return propertyMap
    }
    
    /// Get a dictionary of properties that reference Kinvey entities in other collections.
    override static func kinveyPropertyToCollectionMapping() -> [NSObject : AnyObject]! {
        return [
            "user": KCSUserCollectionName
        ]
    }

}
