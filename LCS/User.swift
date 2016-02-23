//
//  User.swift
//  LCS
//
//  Created by Lauren Nicole Roth on 2/22/16.
//  Copyright © 2016 LuvCur. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    var name : String
    var image : UIImage
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
//    let name: String?
//    let imageURL: String?
//    
//    init(name: String, imageURL: String?) {
//        self.name = name
//        self.imageURL = imageURL
//    }
//    
//    var image : UIImage? {
//        didSet {
//            image = setDefaultImage()
//            if imageURL != nil {
//                fetchImage()
//            } else {
//                setDefaultImage()
//            }
//        }
//    }
//    
//    private func setDefaultImage() -> UIImage{
//        return UIImage(named: "default-image")!
//    }
//    
//    private func fetchImage() {
//        if let url = NSURL(string: imageURL!) {
//            //add spinner here
//            print("fetching image")
//            let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
//            dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
//                let imageData = NSData(contentsOfURL: url) //blocks thread it's on, but not main
//                dispatch_async(dispatch_get_main_queue()) {
//                    if url == self.imageURL {
//                        if imageData != nil {
//                            self.image = UIImage(data: imageData!)!
//                        } else {
//                            self.image = nil
//                        }
//                    }
//                }
//            }
//        }
//    }
}