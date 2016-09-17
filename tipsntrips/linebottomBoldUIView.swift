//
//  linebottomBoldUIView.swift
//  Tips n Trips
//
//  Created by Billy Chen on 3/7/16.
//  Copyright © 2016 iTech Ultimate. All rights reserved.
//

import UIKit

class linebottomBoldUIView: UIView {

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(1.0)
        context.setStrokeColor(UIColor.flatGray().cgColor)
        
        context?.move(to: CGPoint(x: 0, y: self.frame.height))
        context?.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        
        context?.strokePath()
        
    }

}
