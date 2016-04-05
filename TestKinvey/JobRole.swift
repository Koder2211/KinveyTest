//
//  JobRole.swift
//  TestKinvey
//
//  Created by Santosh Surve on 3/30/16.
//  Copyright © 2016 mindscrub. All rights reserved.
//

import Foundation

class JobRole : NSObject {    //all NSObjects in Kinvey implicitly implement KCSPersistable
    var entityId: String? //Kinvey entity _id
    var name: String?
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId, //the required _id field
            "name" : "name",
        ]
    }
}
