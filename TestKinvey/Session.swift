//
//  Session.swift
//  VStar
//
//  Created by Edward LoPinto on 3/31/16.
//  Copyright © 2016 WPM Consulting Inc. All rights reserved.
//

import Foundation

/**
An object conforming to the `KCSPersistable` protocol to represent entities from the Sessions
collection.
*/
class Session: NSObject {

    // MARK: - KCSPersistable properties

    /// The Kinvey object ID
    var entityId: String?  //required Kinvey property

    /// Metadata such as last write time, creation time, etc.
    var metadata: KCSMetadata?  //optional Kinvey property
    
    // MARK: - StoreOptions

    /// The dictionary to pass to `KCSAppDataStore.storeWithOptions` to query the `Sessions`
    /// collection
    static let defaultStoreOptions: [NSObject: AnyObject] = [
        KCSStoreKeyCollectionName: "Sessions",
        KCSStoreKeyCollectionTemplateClass: Session.self
    ]

    // MARK: - Other properties

    /// The start time of the session
    var time: NSDate?

    /// The locations a parent has chosen as possible when requesting a session
    //var possibleLocations: [String]?

    /// The address where the session will take place
    var location: String?

    /// The sport for the session
    var sport: String?

    /// The parent who requested the session
    var parent: Parent?

    /// The coach who was requested for the session
    var coach: Coach?

    /// A dictionary containing information about the child to be coached
    private(set) var _child: NSDictionary?

    /// The child to be coached
//    var child: Child? {
//        get {
//            var childStruct: Child?
//
//            if let dict = _child {
//                childStruct = Child(withKinveyDict: dict)
//            }
//
//            return childStruct
//        }
//        set {
//            if let childStruct = newValue {
//                _child = childStruct.propertyDictionary
//            }
//        }
//    }

    /// A message from the parent to the coach describing the child and goals for the session
    var parentMessage: String?

    /// A boolean value representing whether or not the coach has confirmed the booking
    var confirmed: NSNumber?

    /// A boolean value representing whether or not the session is over
    var complete: NSNumber?

    // MARK: - KCSPersistable
    
    // Required method
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        let propertyMap = [
            "entityId": KCSEntityKeyId,
            "metadata": KCSEntityKeyMetadata,
            "time": "time",
            "location": "location",
            "sport": "sport",
            "parent": "parent",
            "coach": "coach",
            "_child": "child",
            "parentMessage": "parentMessage",
            "confirmed": "confirmed",
            "complete": "complete"
        ]
        
        return propertyMap
    }

    // Use kinveyPropertyToCollectionMapping if the entity includes properties that are references
    // to entities in another Kinvey collection.
    override static func kinveyPropertyToCollectionMapping() -> [NSObject : AnyObject]! {
        // NOTE: I've tried excluding the `.user` properties, and it had no effect on the query
        // issue
        return [
            "parent": "Parents",
            "coach": "Coaches",
        ]
    }
    
    /*
    // Optional: help kinvey determine the class of properties that reference arrays or sets.
    override static func kinveyObjectBuilderOptions() -> [NSObject : AnyObject]! {
        return [
            KCS_REFERENCE_MAP_KEY : [
                "objectProperty" : Class.self
            ]
        ]
    }
    */
    
    /*
    // Optional: automatically save referenced entities in other collections.
    override func referenceKinveyPropertiesOfObjectsToSave() -> [AnyObject]! {
        return ["backendKey"]
    }
    */
}
