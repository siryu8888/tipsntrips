import UIKit
import ChameleonFramework
import UIColor_Hex_Swift

class linebottomUIView: UIView {

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(0.7)
        context.setStrokeColor(UIColor(rgba: "#ABADB0").cgColor)
        
        context?.move(to: CGPoint(x: 10, y: self.frame.height))
        context?.addLine(to: CGPoint(x: self.frame.width - 10, y: self.frame.height))
        
        context?.strokePath()
        
    }


}
