//
//  ProfileCollectionViewCell.swift
//  Tips n Trips
//
//  Created by Billy Chen on 2/25/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit
import Spring
import Kingfisher

class ProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var profilePhoto: DesignableImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileBio: UILabel!
    @IBOutlet weak var profileWebsite: UILabel!
    @IBOutlet weak var profilePlace: UILabel!
    @IBOutlet weak var editProfileBtn: DesignableButton!
    
    @IBOutlet weak var postCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initProfileImage()
    }
    
    func initProfileImage()
    {
        self.profilePhoto.cornerRadius = self.profilePhoto.frame.size.height / 2
        self.profilePhoto.clipsToBounds = true
    }

    
    @IBAction func editProfileClicked(sender: AnyObject) {
        
    }
   
}
