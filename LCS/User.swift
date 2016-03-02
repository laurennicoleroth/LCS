//
//  User.swift
//  LCS
//
//  Created by Lauren Nicole Roth on 2/22/16.
//  Copyright © 2016 LuvCur. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class User {
    
    private var _bio: String?
    private var _imageUrl: String?
    private var _username: String!
    private var _name: String?
    private var _userKey: String!
    private var _userRef: Firebase!
    
    
    // public variable
    var bio: String {
        return _bio!
    }
    
    var name: String {
        return _name!
    }
    
    var imageUrl: String? {
        return _imageUrl
    }
    
    var username: String {
        return _username
    }
    
    var postKey: String {
        return _userKey
    }
    
    // create an initializer
    init(bio: String, imageUrl: String?, username: String) {
        self._bio = bio
        self._imageUrl = imageUrl
        self._username = username
    }
    
    // convert data downloaded from Firebase into dictionary
    init(userKey: String, dictionary: Dictionary<String, AnyObject>) {
        self._userKey = postKey
        
        
        if let imageUrl = dictionary["imageURL"] as? String {
            self._imageUrl = imageUrl
        }
        
        if let bio = dictionary["bio"] as? String {
            self._bio = bio
        }
        
        // grab ref to specific post
        self._userRef = FirebaseDataSingleton.ds.REF_POSTS.childByAppendingPath(self._userKey)
    }
    
    
    func saveToFirebase() {
//        var data: NSData = NSData()
//        data = UIImageJPEGRepresentation(image!, 0.1)!
//        let base64String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
//        let user: NSDictionary = ["name":name!, "photoBase64":base64String]
//        let profile = firebase.ref.childByAppendingPath(name!)
//        profile.setValue(user)
    }
    
    
    private func createImageFromBase64(base64String: String?) -> UIImage? {
        let decodedData = NSData(base64EncodedString: base64String!, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        let decodedImage = UIImage(data: decodedData!)
        return decodedImage!
    }
}