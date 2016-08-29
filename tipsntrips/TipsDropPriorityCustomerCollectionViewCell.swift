//
//  TipsDropPriorityCustomerCollectionViewCell.swift
//  Tips n Trips
//
//  Created by Billy Chen on 2/22/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit
import Spring

class TipsDropPriorityCustomerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var picture: DesignableImageView!
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
}
