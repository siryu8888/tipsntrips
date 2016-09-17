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
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(0.7)
        context.setStrokeColor(UIColor(rgba: "#ABADB0").cgColor)
        
        context?.move(to: CGPoint(x: 10, y: 5))
        context?.addLine(to: CGPoint(x: self.frame.width - 10, y: 5))
        
        context?.strokePath()
        
    }

}
