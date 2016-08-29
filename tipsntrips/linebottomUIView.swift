import UIKit
import ChameleonFramework
import UIColor_Hex_Swift

class linebottomUIView: UIView {

    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 0.7)
        CGContextSetStrokeColorWithColor(context, UIColor(rgba: "#ABADB0").CGColor)
        
        CGContextMoveToPoint(context, 10, self.frame.height)
        CGContextAddLineToPoint(context, self.frame.width - 10, self.frame.height)
        
        CGContextStrokePath(context)
        
    }


}
