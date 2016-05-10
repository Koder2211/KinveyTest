//
//  Coach.swift
//  VStar
//
//  Created by Edward LoPinto on 3/3/16.
//  Copyright © 2016 WPM Consulting Inc. All rights reserved.
//

import Foundation

/**
An object that conforms to `KCSPersistable` and encapsulates information from an entity in the
`Coaches` collection on Kinvey.
 */
 enum VStarUserType {
 case Coach
 case Parent
 
 }

enum Sex {
    case male
    case female
    
}
 

class Coach: NSObject {

    // MARK: - KCSPersistable properties

    /// The Kinvey object ID
    var entityId: String?  //required Kinvey property

    /// Metatdata such as last write time, creation time, etc.
    var metadata: KCSMetadata?  //optional Kinvey property

    // MARK: - StoreOptions

    /// The dictionary to pass to `KCSAppDataStore.storeWithOptions` to query the `Coaches`
    /// collection
    static let defaultStoreOptions: [NSObject: AnyObject] = [
        KCSStoreKeyCollectionName: "Coaches",
        KCSStoreKeyCollectionTemplateClass: Coach.self
    ]
    
    // Add properties for your entity here.

    // MARK: - ExtendedUserInfo properties

    /// The type of VStar user: either Parent or Coach
    let userType = VStarUserType.Coach

    /// The Kinvey user this data belongs to.
    var user: KCSUser?

    /// The current location of the `user`'s device.
    var currentLocation: CLLocation?

    // MARK: - Other properties

    /// The name of this coach's high school.
    var highSchool: String?

    /// The coach's current grade level.
    var grade: NSNumber?

    /// A boolean value representing whether or not this coach provides general fitness training in
    /// addition to training for specific sports.
    var physicalFitness: NSNumber?

    /// The sport or sports the coach plays.
    var sports: [String]?

    /// A brief biography of this coach.
    var message: String?

    /// The average review score given to this coach by parents.
    var avgReviewScore: NSNumber?

    /// The Kinvey object ID of the coach's picture file.
    var pictureFileId: String?

    /// A coach's Braintree merchantId
    var merchantId: String?

    /// The coach's gender, represented as an NSNumber. 0 represents male, 1 represents female.
    private(set) var _gender: NSNumber?

    /// The coach's gender, represented as a case of `Sex`.
//    var gender: Sex? {
//        get {
//            var sex: Sex?
//            if let storedGender = _gender {
//                sex = Sex(rawValue: storedGender.integerValue)
//            }
//            return sex
//        }
//        set {
//            _gender = newValue?.rawValue
//        }
//    }

    /// This coach's availability, represented as an array of pairs of ISO 8601 strings, which can
    /// be saved on Kinvey.
    private(set) var availabilityArray: NSArray?

    /// This coach's availability.
//    var availability: WeeklyAvailability? {
//        get {
//            var storedAvailability: WeeklyAvailability?
//
//            if let array = availabilityArray {
//                storedAvailability = WeeklyAvailability(withKinveyArray: array)
//            }
//
//            return storedAvailability
//        }
//        set {
//            if let availabilityToStore = newValue {
//                availabilityArray = availabilityToStore.arrayForKinvey
//            }
//        }
//    }

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
            "pictureFileId": "pictureFileId",
            "highSchool": "highSchool",
            "grade": "grade",
            "physicalFitness": "physicalFitness",
            "sports": "sports",
            "message": "message",
            "merchantId": "merchantId",
            "availabilityArray": "availability",
            "currentLocation": KCSEntityKeyGeolocation,
            "_gender": "gender",
            "avgReviewScore": "avgReviewScore"
        ]
        
        return propertyMap
    }
    
    /// Get a dictionary of properties that reference Kinvey entities in other collections.
    override static func kinveyPropertyToCollectionMapping() -> [NSObject : AnyObject]! {
        return [
            "user": KCSUserCollectionName
        ]
    }

    // MARK: - Profile picture helper methods

    /**
    Save the coach's profile picture to the Kinvey file store, and set the value of `profileFileId`.
     
    - parameter image:  The UIImage of the user's profile picture.
    */
    func saveProfilePicture(image: UIImage?) {
        if let img = image {
            let imageData = UIImagePNGRepresentation(img)
            
            let metadata = KCSMetadata()
            metadata.setGloballyReadable(true)  //Set to true for other users to be able to see it.
            
            KCSFileStore.uploadData(imageData,
                options: [KCSFileACL: metadata],
                completionBlock: { (savedFile, error) -> Void in

                if let returnedError = error {
                    NSLog(returnedError.localizedDescription)
                }
                    
                self.pictureFileId = savedFile.fileId
            }, progressBlock: nil)
        }
    }

    /**
    Download the coach's profile picture, and call `completion` when the download finishes.
     
    - parameter completion: A closure that takes an optional `UIImage` as the parameter. It will
     be set to the coach's profile picture if the download is successful, otherwise it will be
    `nil`.
    */
    func getProfilePicture(completion: (UIImage?) -> Void) {
        KCSFileStore.downloadData(pictureFileId, completionBlock: { (results, error) in
            if let fileData = (results as? [KCSFile])?.first?.data {
                completion(UIImage(data: fileData))
            } else {
                completion(nil)
            }
        }, progressBlock:  nil)
    }

}
