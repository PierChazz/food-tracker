//
//  Meal.swift
//  FoodTracker
//
//  Created by Pierre pc. CHARVOZ on 04/11/2016.
//  Copyright © 2016 Pierre pc. CHARVOZ. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating : Int
    
    //MARK Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")

    
    //MARK : types 
    
    struct PropertyKey{
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }

// MARK: Initialization

init?(name: String, photo: UIImage?, rating: Int){
    
    self.name = name
    self.photo = photo
    self.rating = rating
    
    super.init()
    
    //Initialization should fail if there is no name or if the rating is negative
    if name.isEmpty || rating < 0 {
        return nil
    }
    }
    
    //MARK : NSCoding
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder adecoder : NSCoder){
        let name = adecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        //Because photo is an optionnal property of Meal, use conditionnal cast
        let photo = adecoder.decodeObjectForKey(PropertyKey.photoKey) as! UIImage
        let rating = adecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        
        //Must call designated initializer
        self.init(name: name, photo: photo, rating: rating)
    }
}
