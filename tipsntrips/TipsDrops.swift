//
//  TipsDrops.swift
//  Tips n Trips
//
//  Created by Billy Chen on 3/6/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit

class TipsDrops: NSObject {
    
    static let sharedInstance:TipsDrops = TipsDrops()
    var tipsDrop:[TipsDrop] = [TipsDrop]()
    var tipsDropAll:[TipsDrop] = [TipsDrop]()
    var expectedRow:Int = 0
    
}
