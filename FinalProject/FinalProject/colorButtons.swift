import UIKit
import Foundation

class PushButtonViewR: UIButton
{
    override func drawRect(rect: CGRect)
    {
        let path = UIBezierPath(ovalInRect: CGRectMake(bounds.minX, rect.minY, bounds.width, bounds.height))
        UIColor(red:190/255, green:0/255,blue: 0/255, alpha:1).setFill()
        path.fill()
        
        if red == true
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

class PushButtonViewO: UIButton
{
    override func drawRect(rect: CGRect)
    {
        let path = UIBezierPath(ovalInRect: CGRectMake(bounds.minX, rect.minY, bounds.width, bounds.height))
        UIColor(red:255/255, green:127/255,blue: 80/255, alpha:1).setFill()
        path.fill()
        if orange == true
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

class PushButtonViewG: UIButton
{
    override func drawRect(rect: CGRect)
    {
        let path = UIBezierPath(ovalInRect: CGRectMake(bounds.minX, rect.minY, bounds.width, bounds.height))
        UIColor(red:60/255, green:179/255,blue: 113/255, alpha:1).setFill()
        path.fill()
        if green == true
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

class PushButtonViewB: UIButton
{
    override func drawRect(rect: CGRect)
    {
        let path = UIBezierPath(ovalInRect: CGRectMake(bounds.minX, rect.minY, bounds.width, bounds.height))
        UIColor(red:49.5/255, green:130/255,blue: 157.5/255, alpha:1).setFill()
        path.fill()
        if blue == true
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

class PushButtonViewP: UIButton
{
    override func drawRect(rect: CGRect)
    {
        let path = UIBezierPath(ovalInRect: CGRectMake(bounds.minX, rect.minY, bounds.width, bounds.height))
        UIColor(red:75/255, green:0/255,blue: 130/255, alpha:1).setFill()
        path.fill()
        if purple == true
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