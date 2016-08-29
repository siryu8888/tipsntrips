//
//  linebottomBoldUIView.swift
//  Tips n Trips
//
//  Created by Billy Chen on 3/7/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit

class linebottomBoldUIView: UIView {

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 1.0)
        CGContextSetStrokeColorWithColor(context, UIColor.flatGrayColor().CGColor)
        
        CGContextMoveToPoint(context, 0, self.frame.height)
        CGContextAddLineToPoint(context, self.frame.width, self.frame.height)
        
        CGContextStrokePath(context)
        
    }

}
