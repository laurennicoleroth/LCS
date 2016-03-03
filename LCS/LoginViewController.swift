//
//  LoginViewController.swift
//  LCS
//
//  Created by Lauren Nicole Roth on 3/1/16.
//  Copyright © 2016 LuvCur. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if DEFAULTS.valueForKey(KEY_UID) != nil {
//            self.performSegueWithIdentifier(SEGUE_LOGGEDIN, sender: nil)
            print("key for user is not nil")
        }
    }
    
    //-------------------------------------
    // MARK: - Facebook Login Button Tapped
    //-------------------------------------
    @IBAction func facebookLoginButtonTapped(sender: AnyObject) {
        // create new instance of facebookLogin
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logInWithReadPermissions(["email"], fromViewController:self, handler: { (facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            
            if facebookError != nil {
                print("Facebook login failed. Error \(facebookError)")
            } else {
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                print("successfully logged in with facebook \(accessToken)")
                
                FirebaseDataSingleton.ds.REF_BASE.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { error, authData in
                    
                    // store on our device the token/session of our user when they log in w Facebook
                    if error != nil {
                        print("Login failed. \(error)")
                    } else {
                        print("Logged in! \(authData)")
                        DEFAULTS.setValue(authData.uid, forKey: KEY_UID)
                        
                        
                        // Create a new firebase user if they used facebook to sign up
                        let user = ["provider": authData.provider!, "blah": "swa"]
                        FirebaseDataSingleton.ds.createFirebaseUser(authData.uid, user: user)
                        
                        // move to new VC after logging in
                        self.performSegueWithIdentifier(SEGUE_LOGGEDIN, sender: nil)
                    }
                })
            }
        })
    }
    
    //-------------------------------------
    // MARK: - Login / Signup Button Tapped
    //-------------------------------------
    @IBAction func loginSignupButtonTapped(sender: AnyObject) {
        
        if let email = emailTextField.text where email != "", let password = passwordTextField.text where password != "" {
            
            // login/authenticate a user
            FirebaseDataSingleton.ds.REF_BASE.authUser(email, password: password, withCompletionBlock: { error, authData in
                
                if error != nil {
                    
                    print(error.code) // -8 for account does not exist
                    
                    
                    // Handle error if account doesn't exist
                    if error.code == STATUS_ACCOUNT_NOTEXIST {
                        // Create a new user account
                        FirebaseDataSingleton.ds.REF_BASE.createUser(email, password: password, withValueCompletionBlock: { error, result in
                            
                            if error != nil {
                                self.showErrorAlert("Could not create account", msg: "Make sure your information is correct.")
                            } else {
                                // successfully created an account, save user id and
                                // log in user
                                DEFAULTS.setValue(result[KEY_UID], forKey: KEY_UID)
                                
                                FirebaseDataSingleton.ds.REF_BASE.authUser(email, password: password, withCompletionBlock: { err, authData in
                                    
                                    // Create a new firebase user if they used email to sign up
                                    let user = ["provider": authData.provider!]
                                    FirebaseDataSingleton.ds.createFirebaseUser(authData.uid, user: user)
                                    
                                })
                                
                                self.performSegueWithIdentifier(SEGUE_LOGGEDIN, sender: nil)
                            }
                        })
                    } else {
                        // Handle error if incorrect password
                        self.showErrorAlert("Could not log in.", msg: "You may have entered your password or email incorrectly.")
                    }
                    
                } else {

                    DEFAULTS.setValue(authData.uid, forKey: KEY_UID)
                    self.performSegueWithIdentifier(SEGUE_LOGGEDIN, sender: nil)
                }
            })
            
        } else {
            showErrorAlert("Missing Something?", msg: "You must enter an email and a password.")
        }
    }
    
    //-------------------
    // MARK: - Show Alert
    //-------------------
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Got it.", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
}
