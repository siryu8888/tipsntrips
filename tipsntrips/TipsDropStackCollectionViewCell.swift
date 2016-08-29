//
//  TipsDropStackCollectionViewCell.swift
//  Tips n Trips
//
//  Created by Billy Chen on 2/19/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit
import Spring

class TipsDropStackCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var picture: DesignableImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
