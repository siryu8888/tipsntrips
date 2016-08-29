//
//  UserProfile.swift
//  tipsntrips
//
//  Created by Billy Chen on 6/9/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit

class UserProfile: NSObject {
    
    static let sharedInstance : UserProfile = UserProfile(name: "",uid: "")
    
    var uid:String
    var name:String
    var email:String?
    var bio:String?
    var photo_url:NSURL?
    
    init(name:String,uid:String) {
        self.name = name
        self.uid = uid
    }
    
    
    /*
     * ============
     * SETTER
     * ============
     */
    func setUserEmail(email:String)
    {
        self.email = email
    }
    func setUserBio(bio:String)
    {
        self.bio = bio
    }
    func setPhotoUrl(photo_url:NSURL)
    {
        self.photo_url = photo_url
    }
    
    
    /*
     * ============
     * GETTER
     * ============
     */
    
    func getUserEmail()->String
    {
        return self.email!
    }
    
    func getUserBio()->String
    {
        return self.bio!
    }
    
    func getPhotoUrl()->NSURL
    {
        return self.photo_url!
    }

}
