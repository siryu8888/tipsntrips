//
//  DataService.swift
//  tipsntrips
//
//  Created by Billy Chen on 6/9/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit
import Firebase
import FBSDKShareKit
import SwiftyJSON

class DataService: NSObject {
    static let sharedInstance:DataService = DataService()
    
    typealias CompletionHandler = (_ success:Bool,_ msg:String) ->Void
    
    fileprivate var _BASE_REF :FIRDatabaseReference = FIRDatabase.database().reference()
    fileprivate var _USER_REF :FIRDatabaseReference = FIRDatabase.database().reference().child("users")
    fileprivate var _MY_TIPSDROP__REF : FIRDatabaseReference = FIRDatabase.database().reference().child("mytipsdrop")
    fileprivate var _CATEGORIES_REF:FIRDatabaseReference = FIRDatabase.database().reference().child("categories")
    
    
    func getBaseRef()->FIRDatabaseReference
    {
        return self._BASE_REF
    }
    
    func getUserRef()->FIRDatabaseReference
    {
        return self._USER_REF
    }
    
    func getMyTipsdropRef()->FIRDatabaseReference
    {
        return self._MY_TIPSDROP__REF
    }
    
    func initiateCategories(){
        _CATEGORIES_REF.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.value is NSNull{
                print("Category Not Found")
            }
            else{
                
                if let categories = snapshot.value as?[String:AnyObject]{
                    for (key,value) in categories{
                        let dict: Category = Category()
                        dict.categoryName = key
                        let val = JSON(value)
                        dict.icon_active_url = val["icon_active_url"].string!
                        dict.icon_inactive_url = val["icon_inactive_url"].string!
                        dict.categoryImage.kf_setImageWithURL(URL(string: dict.icon_active_url)!)
                        Categories.sharedInstance.category.append(dict)
                    }
                }
            }
        })
    }
    
    
//    func getMyTipsdrop(){
//        if let user = FIRAuth.auth()?.currentUser{
////            let recentpost = _MY_TIPSDROP__REF.child(user.uid).queryLimitedToFirst(10)
////            print(recentpost)
//            _MY_TIPSDROP__REF.child(user.uid).queryLimitedToFirst(10).observeSingleEventOfType(.Value, withBlock: {(snapshot) in
//                if snapshot.value is NSNull{
//                    print("Not Found")
//                }else{
//                    if let myposts = snapshot.value as? [String:AnyObject]{
//                        for(key,value) in myposts{
//                            let dict:TipsDrop = TipsDrop()
//                            dict.tipsDropID = key
//                            dict.timestamp  = value["timestamp"] as! String
//                            dict.tipsDropTitle = value["title"] as! String
//                            dict.tipsDropCategoryName = value["category_name"] as! String
//                            dict.tipsDropLike = Int(value["like_counter"] as! String)!
//                            dict.tipsDropComment = Int(value["comment_counter"]as!String)!
//                            dict.tipsDropContent = value["content"] as! String
//                            dict.tipsDropImgUrl = NSURL(string:value["cover_photo_url"] as! String)!
//                            dict.tipsDropAuthorUID = UserProfile.sharedInstance.uid
//                            dict.tipsDropAuthorName = UserProfile.sharedInstance.name
//                            dict.tipsDropAuthorImgUrl = UserProfile.sharedInstance.photo_url
//                            
//                            TipsDrops.sharedInstance.tipsDrop.append(dict)
//                        }
//                    }
////                  Sorting Descending by timestamp
//                    TipsDrops.sharedInstance.tipsDrop.sortInPlace({$0.timestamp > $1.timestamp})
//                    
//                }
//            })
//        }
//    }
    func isLoggedIn(_ status:@escaping CompletionHandler)
    {
        if UserProfile.sharedInstance.uid == "" {
            if let user = FIRAuth.auth()?.currentUser{
                _USER_REF.child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    if(snapshot.value is NSNull){
                        print("not found")
                    }
                    else{
                        if let allProfile = snapshot.value as? [String:AnyObject]{
                            UserProfile.sharedInstance.uid = user.uid
                            UserProfile.sharedInstance.name  = allProfile["display_name"] as! String
                            UserProfile.sharedInstance.email = allProfile["email"] as? String
                            if(allProfile["login_provider"] as! String == "FACEBOOK"){
                                UserProfile.sharedInstance.setPhotoUrl(URL(string: (allProfile["photo_url"] as? String)!)!)
                                print(UserProfile.sharedInstance.photo_url)
                            }
                        }
                    }
                    status(true, "User Logged In")
                    return
                })
                
                
            }else{
                status(false, "User Not Logged In")
                return
            }
        }
        else{
            status(false, "User Not Logged In")
            return
        }

        
    }
    
    func authWithEmail(_ email:String,pass:String,status:@escaping CompletionHandler)
    {
        FIRAuth.auth()?.signIn(withEmail: email, password: pass) { (user, error) in
            if error == nil{
                UserProfile.sharedInstance.uid = (user?.uid)!
                status(true, "Logged In")
                return
            }else{
                status(false, (error?.localizedDescription)!)
                return
            }
        }
    }
    
    func authWithFB(_ credential:FIRAuthCredential,status:@escaping CompletionHandler)
    {
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            print(error.debugDescription)
            
            self.getFBProfilePicture({ (success, msg) in
                if(success){
                    if error == nil{
                        for profile in (user?.providerData)!{
                            UserProfile.sharedInstance.uid = (user?.uid)!
                            UserProfile.sharedInstance.email = profile.email!
                            UserProfile.sharedInstance.name = profile.displayName!
                            
                            let params = [
                                "display_name" : "\(profile.displayName!)",
                                "email":"\(profile.email!)",
                                "photo_url":"\(UserProfile.sharedInstance.photo_url!)",
                                "login_provider" : "FACEBOOK"
                            ]
                            DataService.sharedInstance.getUserRef().child(UserProfile.sharedInstance.uid).updateChildValues(params)
                            status(true, "Logged In")
                            return
                        }
                    }else{
                        status(false, (error?.localizedDescription)!)
                        return
                    }
                }
            })
            
        }
    }
    
    func getFBProfilePicture(_ completionHandler:@escaping CompletionHandler)
    {
        
        let profilePict = FBSDKGraphRequest(graphPath: "me/picture", parameters: ["height":300,"width":300,"redirect":false], httpMethod: "GET")
        profilePict?.start { (connection, result, error) in
            if(error == nil){
                let data = JSON(result)
                for _ in 0 ..< data.count {
                    print(data["data"]["url"])
                    UserProfile.sharedInstance.photo_url = URL(string:data["data"]["url"].string!)!
                    print("Finish Get PP")
                    completionHandler(success: true, msg: "Finish Fetching PP")
                    
                }
            }
        }
    }
    
}
