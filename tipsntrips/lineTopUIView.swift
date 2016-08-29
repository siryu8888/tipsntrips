//
//  lineTopUIView.swift
//  Tips n Trips
//
//  Created by Billy Chen on 3/15/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit

class lineTopUIView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 0.7)
        CGContextSetStrokeColorWithColor(context, UIColor(rgba: "#ABADB0").CGColor)
        
        CGContextMoveToPoint(context, 10, 5)
        CGContextAddLineToPoint(context, self.frame.width - 10, 5)
        
        CGContextStrokePath(context)
        
    }

}
