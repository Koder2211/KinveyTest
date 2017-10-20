//
//  JobRole.swift
//  TestKinvey
//
//  Created by Santosh Surve on 3/30/16.
// Test this file - with latest kinvey sdk
//  Copyright © 2016 mindscrub. All rights reserved.
//

import Foundation

class Info : NSObject {    //all NSObjects in Kinvey implicitly implement KCSPersistable
    var _id: String? //Kinvey entity _id
    var _filename: String?
    var size: String?
    var mimetype: String?
    var _downloadURL: String?
    var _type: String?
    
    init(id: String, filename: String) {
        
        super.init()
        _id = id
        _filename = filename
    }

    
    
   }

class JobRole : NSObject {    //all NSObjects in Kinvey implicitly implement KCSPersistable
    var entityId: String? //Kinvey entity _id
    var name: String?
    var date: NSDate?
    var fileInfo: KCSFile?
    var user: KCSUser?
    var data: NSMutableArray?


    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId, //the required _id field
            "name" : "name",
            "date" : "date",
             "fileInfo" : "fileInfo",
             "user": "user",
             "data":"data"
        ]
    }
    
//    static override func kinveyPropertyToCollectionMapping() -> [NSObject : AnyObject]! {
//        return [
//            "user" : KCSCollectionName
//            
//        ]}
    
}
