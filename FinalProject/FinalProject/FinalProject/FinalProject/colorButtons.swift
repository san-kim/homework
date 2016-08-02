import UIKit
import Foundation


@IBDesignable class PushButtonView: UIButton
{
    @IBInspectable var color: UIColor = UIColor(red:190/255, green:0/255,blue: 0/255, alpha:1)

    
    override func drawRect(rect: CGRect)
    {
        let path = UIBezierPath(ovalInRect: CGRectMake(bounds.minX, rect.minY, bounds.width, bounds.height))
        UIColor(red:190/255, green:0/255,blue: 0/255, alpha:1).setFill()
        color.setFill()
        path.fill()
        
        
        //for each case, only way to check what type of button/color it represents, use the color == ... to mark the correct checkbox 
        if red == true && color == UIColor(red:190/255, green:0/255,blue: 0/255, alpha:1)
        {
            let check = UIBezierPath()
            check.lineWidth = 1.5
            check.moveToPoint(CGPoint(x:bounds.width/3.5 - bounds.width/30, y:bounds.height/2))
            check.addLineToPoint(CGPoint(x:bounds.midX - bounds.width/30, y:bounds.midY + bounds.height/5))
            check.addLineToPoint(CGPoint(x:bounds.width*0.75 - bounds.width/30, y:bounds.midY - bounds.height/4))
            UIColor.whiteColor().setStroke()
            check.stroke()
        }

        if orange == true && color == UIColor(red:255/255, green:133/255,blue: 84/255, alpha:1)
        {
            let check = UIBezierPath()
            check.lineWidth = 1.5
            check.moveToPoint(CGPoint(x:bounds.width/3.5 - bounds.width/30, y:bounds.height/2))
            check.addLineToPoint(CGPoint(x:bounds.midX - bounds.width/30, y:bounds.midY + bounds.height/5))
            check.addLineToPoint(CGPoint(x:bounds.width*0.75 - bounds.width/30, y:bounds.midY - bounds.height/4))
            UIColor.whiteColor().setStroke()
            check.stroke()
        }

        
        if green == true && color == UIColor(red:60/255, green:179/255,blue: 113/255, alpha:1)
        {
            let check = UIBezierPath()
            check.lineWidth = 1.5
            check.moveToPoint(CGPoint(x:bounds.width/3.5 - bounds.width/30, y:bounds.height/2))
            check.addLineToPoint(CGPoint(x:bounds.midX - bounds.width/30, y:bounds.midY + bounds.height/5))
            check.addLineToPoint(CGPoint(x:bounds.width*0.75 - bounds.width/30, y:bounds.midY - bounds.height/4))
            UIColor.whiteColor().setStroke()
            check.stroke()
        }
        
        if blue == true && color == UIColor(red:35/255, green:126/255,blue: 212/255, alpha:1)
        {
            let check = UIBezierPath()
            check.lineWidth = 1.5
            check.moveToPoint(CGPoint(x:bounds.width/3.5 - bounds.width/30, y:bounds.height/2))
            check.addLineToPoint(CGPoint(x:bounds.midX - bounds.width/30, y:bounds.midY + bounds.height/5))
            check.addLineToPoint(CGPoint(x:bounds.width*0.75 - bounds.width/30, y:bounds.midY - bounds.height/4))
            UIColor.whiteColor().setStroke()
            check.stroke()
        }
        
        if purple == true && color == UIColor(red:85/255, green:44/255,blue: 165/255, alpha:1)
        {
            let check = UIBezierPath()
            check.lineWidth = 1.5
            check.moveToPoint(CGPoint(x:bounds.width/3.5 - bounds.width/30, y:bounds.height/2))
            check.addLineToPoint(CGPoint(x:bounds.midX - bounds.width/30, y:bounds.midY + bounds.height/5))
            check.addLineToPoint(CGPoint(x:bounds.width*0.75 - bounds.width/30, y:bounds.midY - bounds.height/4))
            UIColor.whiteColor().setStroke()
            check.stroke()
        }
        
        if black == true && color == UIColor(red:71/255, green:71/255,blue: 71/255, alpha:1)
        {
            let check = UIBezierPath()
            check.lineWidth = 1.5
            check.moveToPoint(CGPoint(x:bounds.width/3.5 - bounds.width/30, y:bounds.height/2))
            check.addLineToPoint(CGPoint(x:bounds.midX - bounds.width/30, y:bounds.midY + bounds.height/5))
            check.addLineToPoint(CGPoint(x:bounds.width*0.75 - bounds.width/30, y:bounds.midY - bounds.height/4))
            UIColor.whiteColor().setStroke()
            check.stroke()
        }
    }
}