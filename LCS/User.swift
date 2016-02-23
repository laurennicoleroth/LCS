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
    
    let firebase = Firebase(url:"https://luvcurios.firebaseio.com/")
    var name : String?
    var image : UIImage? {
        didSet {
            image = UIImage(named: "default-user")
            if imageBase64 != nil {
                image = createImageFromBase64(imageBase64)
            }
        }
    }
    var imageBase64 : String?
    
    
    init(name: String?, image: UIImage?) {
        self.name = name
        if self.image != nil {
            saveToFirebase()
        }
    }
    
    func saveToFirebase() {
        var data: NSData = NSData()
        data = UIImageJPEGRepresentation(image!, 0.1)!
        let base64String = data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        let user: NSDictionary = ["name":name!, "photoBase64":base64String]
        let profile = firebase.ref.childByAppendingPath(name!)
        profile.setValue(user)
    }
    
    
    private func createImageFromBase64(base64String: String?) -> UIImage? {
        let decodedData = NSData(base64EncodedString: base64String!, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
        let decodedImage = UIImage(data: decodedData!)
        return decodedImage!
    }
}