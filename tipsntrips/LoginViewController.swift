//
//  LoginViewController.swift
//  tipsntrips
//
//  Created by Billy Chen on 6/9/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit
import Spring
import Firebase
import Material
import FBSDKLoginKit


class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: DesignableTextField!
    @IBOutlet weak var passwordTF: DesignableTextField!
    @IBOutlet weak var signInFBButton: FBSDKLoginButton!
    @IBOutlet weak var signInButton: MaterialButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
//    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
//        print("FB Button Clicked")
//        if result.isCancelled{
//            let alertController = AlertManager.sharedInstance.alertOKOnly("Canceled", msg: "Login Canceled")
//            self.presentViewController(alertController, animated: true, completion: nil)
//        }
//        else if error != nil{
//            print("Error = \(error.localizedDescription) ")
//        }else{
//            print("Login FB Clicked")
//            let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
//            DataService.sharedInstance.authWithFB(credential) { (success, msg) in
//                if(!success){
//                    let alertController = AlertManager.sharedInstance.alertOKOnly("Login Error", msg: msg)
//                    self.presentViewController(alertController, animated: true, completion: nil)
//                }
//                self.dismissViewControllerAnimated(true, completion: nil)
//            }
//        }
//        
//    }
//    
//    
    @IBAction func fbLoginBtnClicked(_ sender: AnyObject) {
        print("Login FB Clicked")
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email","public_profile","user_friends"], from: self, handler: {
            (facebookResult,facebookError) -> Void in
                print("Login with permission")
                print("\(facebookResult)")
                if facebookError != nil{
                    let alertController = AlertManager.sharedInstance.alertOKOnly("Error", msg: facebookError.localizedDescription)
                    self.present(alertController, animated: true, completion: nil)
                }
                else if (facebookResult?.isCancelled)!{
                    let alertController = AlertManager.sharedInstance.alertOKOnly("Canceled", msg: "Login Canceled")
                    self.present(alertController, animated: true, completion: nil)
                }else{
                    print("Login FB Clicked")
                    let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                    DataService.sharedInstance.authWithFB(credential) { (success, msg) in
                            if(!success){
                                let alertController = AlertManager.sharedInstance.alertOKOnly("Login Error", msg: msg)
                                self.present(alertController, animated: true, completion: nil)
                            }
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        )
    }
    
    @IBAction func SignInBtn(_ sender: AnyObject) {
        
        if emailTF.text == ""{
            let alertController = AlertManager.sharedInstance.alertOKOnly("Email Required", msg: "Please enter registered email address")
            self.present(alertController, animated: true, completion: nil)
        }
        else if(!isValidEmail(emailTF.text!)){
            let alertController = AlertManager.sharedInstance.alertOKOnly("Email Not Valid", msg: "Please enter valid email address")
            self.present(alertController, animated: true, completion: nil)
        }
        else if passwordTF.text == ""{
            let alertController = AlertManager.sharedInstance.alertOKOnly("Password Required", msg: "Please enter valid password")
            self.present(alertController, animated: true, completion: nil)
        }else{
//          Disabling Button
            emailTF.isEnabled = false
            passwordTF.isEnabled = false
            signInButton.isEnabled = false
            
            DataService.sharedInstance.authWithEmail(emailTF.text!, pass: passwordTF.text!, status: { (success, msg) in
                if(!success)
                {
//                  Enabling Button
                    self.emailTF.isEnabled = true
                    self.passwordTF.isEnabled = true
                    self.signInButton.isEnabled = true
                    
                    let alertController = AlertManager.sharedInstance.alertOKOnly("Login Error", msg: msg)
                    self.present(alertController, animated: true, completion: nil)
                }
                else{
                    let email = self.emailTF.text
                    let params = [
                        "email":"\(email!)",
                        "login_provider" : "PASSWORD"
                    ]
                    DataService.sharedInstance.getUserRef().child(UserProfile.sharedInstance.uid).updateChildValues(params)
                }
            })
        }
    }
    
    func isValidEmail(_ email:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    

}
