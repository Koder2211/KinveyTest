//
//  TrainingSessionManager.swift
//  VStar
//
//  Created by Edward LoPinto on 3/31/16.
//  Copyright © 2016 WPM Consulting Inc. All rights reserved.
//

import Foundation

/**
An instance of `TrainingSessionManager` is used to create and edit Session entities on Kinvey.
*/
class TrainingSessionManager {

    /**
    A closure to execute after a Session is saved or updated.
     
    - parameter session:    The updated or saved session, or nil if the operation failed.
    - parameter error:  The error returned by Kinvey if one was thrown, otherwise nil.
    */
    typealias SessionUpdateCompletion = (session: Session?, error: NSError?) -> Void

    typealias SessionQueryCompletion = (sessions: [Session], error: NSError?) -> Void

    /**
    Create and save a Session entity to Kinvey.
     
    - parameter time: The time the session will take place.
     
    - parameter possiblePlaces: An array of the places the parent is willing to take her child to
     for the session.
     
    - parameter parent:  The Kinvey entity for the parent.
     
    - parameter coach: The coach for the session.
     
    - parameter child:  The child to be trained during the session.
     
    - parameter sport:  The sport for the session.
     
    - parameter message:  A brief message from the parent to the coach describing what should be
     accomplished during the session.
     
    - parameter completion:  A closure to be executed when the Kinvey SDK completes the save
     operation. It takes the saved session and an NSError as it's parameters. The `session` will be
     nil if the save fails.
    */
    /*class func makeSessionAtTime(time: NSDate,
        place: String, parent: Parent,
        coach: Coach, child: Child,
        sport: String, message: String,
        completion: SessionUpdateCompletion?)
    {
        let session = Session()
        session.time = time
        session.location = place
        session.coach = coach
        session.parent = parent
        session.child = child
        session.sport = sport
        session.parentMessage = message
        session.confirmed = NSNumber(bool: false)
        session.complete = NSNumber(bool: false)

        if let coachUser = coach.user {
            let metaData = KCSMetadata()
            metaData.writers.addObject(coachUser.userId)
            session.metadata = metaData
        }

        let sessionStore = KCSLinkedAppdataStore.storeWithOptions(Session.defaultStoreOptions)

        sessionStore.saveObject(session, withCompletionBlock: { (results, error) in
            if let session = results?.first as? Session {
                completion?(session: session, error: nil)
            }

            if let returnedError = error {
                completion?(session: nil, error: returnedError)
            }
        }, withProgressBlock: nil)
    }*/

    /**
    Query the Kinvey database and return all of the sessions that involve a user. The user can be
    either a parent or a coach.
     
    - parameter extendedUser:  A Kinvey entity from either the `Parents` or `Coaches` collection.
     
    - parameter completion:  A closure that will be executed when the query completes. It takes as
     its parameters the array of sessions returned by the query and an NSError. If the query fails
     or there are no results, `sessions` will be an emptry array.
    */
    class func getSessionsForExtendedUser()
    {
        let field: String

//        switch extendedUser.userType {
//        case .Coach:
//            field = "coach._id"
//        case .Parent:
//            field = "parent._id"
//        }

        let store = KCSLinkedAppdataStore.storeWithOptions(Session.defaultStoreOptions)

        //let query = KCSQuery(onField: "coach._id", withExactMatchForValue: "57198cfedc10acea5493afb1")
        let query = KCSQuery()

        store.queryWithQuery(query, withCompletionBlock: { (results, error) in
            let sessions = results as? [Session] ?? [Session]()
            
            print("Count is \(sessions.count)")
            
            for var i = 0; i < sessions.count ; ++i {
                var session: Session?
                session = sessions[i] as! Session
                
                print(session?.kinveyObjectId())
                print(session?.parentMessage)
                print(session?.coach?.availabilityArray)
                print(session?.parent?.children)
                
                
            }

            
            //completion?(sessions: sessions, error: error)
        }, withProgressBlock: nil)
    }

}
