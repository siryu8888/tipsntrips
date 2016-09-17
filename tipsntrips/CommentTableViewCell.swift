//
//  CommentTableViewCell.swift
//  Tips n Trips
//
//  Created by Billy Chen on 3/21/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var posterComment: UITextView!
    @IBOutlet weak var posterName: UILabel!
    
    override func awakeFromNib() {

        super.awakeFromNib()
        // Initialization code
        initProfileImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initProfileImage()
    {
        self.posterImg.layer.cornerRadius = self.posterImg.frame.size.height/2
        self.posterImg.clipsToBounds = true
    }

}
