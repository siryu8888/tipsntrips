//
//  Categories.swift
//  tipsntrips
//
//  Created by Billy Chen on 6/12/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit

class Categories: NSObject {

    static let sharedInstance : Categories = Categories()
    var lastUpdated :String = ""
    var category:[Category] = [Category]()
}
