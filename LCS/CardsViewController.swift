//
//  ViewController.swift
//  LCS
//
//  Created by Lauren Nicole Roth on 2/22/16.
//  Copyright © 2016 LuvCur. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController
{
    var users : [User] = []
    
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        createUserStack()
        
        let cardStack = CardStackView(frame: self.frontCardViewFrame())
        cardStack.popCardViewWithFrame = self.popCardViewWithFrame
        
        cardStack.reloadContent()
        
        self.view.addSubview(cardStack)
    }
    
    override func viewWillAppear(animated: Bool) {
        //prepare stack
        createUserStack()
        
    }
    
    
    //MARK: Stack Creation
    func createUserStack() {
        //create some users from image urls and names
        let usersWithURLS : [String: String] = [
            "Lauren": "http://33.media.tumblr.com/avatar_9587e0b81626_128.png",
            "Lauren1": "http://33.media.tumblr.com/avatar_9587e0b81626_128.png",
            "Lauren2": "http://33.media.tumblr.com/avatar_9587e0b81626_128.png",
            "Lauren3": "http://33.media.tumblr.com/avatar_9587e0b81626_128.png",
            "Lauren4": "http://33.media.tumblr.com/avatar_9587e0b81626_128.png",
            "Lauren5": "http://33.media.tumblr.com/avatar_9587e0b81626_128.png"
            ]

        for (name, url) in usersWithURLS {
            users.append(User(name: name, imageURL: url))
        }
        
    }
    
    //MARK: Stack Card View animation
    func popCardViewWithFrame(frame: CGRect) -> UIView? {
        if(users.count == 0) {
            return nil
        } else {
            let user : User = users.removeLast()
            let imageView = UIImageView()
            
            imageView.image = user.image
            imageView.contentMode = UIViewContentMode.ScaleAspectFill
            imageView.clipsToBounds = true
            
            return imageView
        }
    }
    
    func tappedImageView(sender: AnyObject) -> () {
        if let imageView = sender as? UIView {
            UIView.animateWithDuration(0.5, animations: {
                imageView.alpha = 0
                imageView.transform = CGAffineTransformMakeScale(0.01, 0.01)
            })
        }
    }
    
    func frontCardViewFrame () -> CGRect {
        let horizontalPadding : CGFloat = 15
        let topPadding : CGFloat = 120
        let bottomPadding : CGFloat = 120
        
        return CGRectMake(horizontalPadding,
            topPadding,
            CGRectGetWidth(self.view.frame) - (horizontalPadding * 2),
            CGRectGetHeight(self.view.frame) - (bottomPadding) - (topPadding))
    }
    
    
}

