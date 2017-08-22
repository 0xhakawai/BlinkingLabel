//
//  Desk3SignupPresenter.swift
//  SmartDesk3
//
//  Created by sa on 7/18/17.
//  Copyright © 2017 Autonomous Inc. All rights reserved.
//

import UIKit
import AutoBL
import AutoUtil
import GoogleSignIn
import AutoCommon

class Desk3SignupPresenterImpl: SignupPresenterImpl {

    fileprivate var desk3SignupView:Desk3SignupView?

    override init(view: SignupView, repos: UserRepos) {
        super.init(view: view, repos: repos)
        self.desk3SignupView = view as? Desk3SignupView
    }
    
    //MARK: - Internal functions
    func socialLogin(_ data : [String : AnyObject]) {
        self.uRepos?.socialLogin(data, onSuccess: { (object) in
            GlobalMainQueue.async {
                self.desk3SignupView?.hideIndicator()
                self.desk3SignupView?.onSignupCallback(value: true)
            }
        }, onError: { (error) in
            GlobalMainQueue.async {
                self.desk3SignupView?.hideIndicator()
                self.desk3SignupView?.showMessage(error.localizedDescription)
                self.desk3SignupView?.onSignupCallback(value: false)
                
            }
        })
    }


}

extension Desk3SignupPresenterImpl:Desk3SignupPresenter {
    func loginFacebook() {
        GlobalMainQueue.async {
            self.desk3SignupView?.showIndicator()
        }
        FacebookServices.sharedInstance.loginOnSuccess({ (value) in
            
            if value {
                
                FacebookServices.sharedInstance.returnUserData({ (response) in
                    var dict : [String : AnyObject] = response
                    if ((dict["status"] as! String) == "1") {
                        dict["source"] = "facebook" as AnyObject?
                        self.socialLogin(dict)
                        
                    } else {
                        
                        GlobalMainQueue.async {
                            self.desk3SignupView?.hideIndicator()
                            self.desk3SignupView?.showMessage("Facebook error")
                            self.desk3SignupView?.onSignupCallback(value: false)
                            
                        }
                    }
                    
                })
            } else{
                GlobalMainQueue.async {
                    self.desk3SignupView?.hideIndicator()
                    self.desk3SignupView?.showMessage("Facebook error")
                    self.desk3SignupView?.onSignupCallback(value: false)
                    
                }
            }
            
        }, onError: { (message) in
            GlobalMainQueue.async {
                self.vSignup?.hideIndicator()
                self.vSignup?.showMessage(message)
                self.desk3SignupView?.onSignupCallback(value: false)
                
            }
        })
        
    }
    
    func loginGoogle() {
        GlobalMainQueue.async {
            self.vSignup?.showIndicator()
        }
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
}
extension Desk3SignupPresenterImpl:GIDSignInDelegate {
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Swift.Error!) {
        
        GlobalMainQueue.async {
            self.desk3SignupView?.hideIndicator()
            if (error == nil) {
                var response : [String : AnyObject] = [:]
                // Perform any operations on signed in user here.
                response["sid"] = user.userID as AnyObject?                  // For client-side use only!
                response["token"] = user.authentication.accessToken as AnyObject? // Safe to send to the server
                response["name"] = user.profile.name as AnyObject?
                response["email"] = user.profile.email as AnyObject?
                response["username"] = user.profile.name as AnyObject?
                response["source"] = "google" as AnyObject?
                
                self.socialLogin(response)
            } else {
                self.desk3SignupView?.showMessage(error.localizedDescription)
                self.desk3SignupView?.onSignupCallback(value: false)
            }
        }
        
        
    }
}
extension Desk3SignupPresenterImpl:GIDSignInUIDelegate{
    public func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!){
        self.desk3SignupView?.googleSignInPresent(viewController: viewController)
    }
    
    public func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!){
        self.desk3SignupView?.googleSignInDismiss(viewController: viewController)
    }
}
