//
//  GridView
//  FinalProject
//
//  Created by Kiwook Kim on 7/25/16.
//  Copyright © 2016 sankim. All rights reserved.
//

import Foundation
import UIKit
var lastPoint:Position = (0,0)

class GridView: UIView
{
    
    var points:[(Int,Int)]?
    {
        get
        {
            var newValue: [(Int,Int)] = []
            _ = StandardEngine.sharedInstance.grid.cells.map
            {
                switch $0.state
                {
                    case .Living:
                        newValue.append($0.position)
                    case .Born:
                        newValue.append($0.position)
                    default: break
                }
            }
            return newValue
        }
        
        set(newValue)
        {
            let rows = StandardEngine.sharedInstance.grid.rows
            let cols = StandardEngine.sharedInstance.grid.cols
            StandardEngine.sharedInstance.grid = Grid(rows,cols, cellInit: {_ in .Empty})
            if let points = newValue {
                _ = points.map{
                    StandardEngine.sharedInstance.grid[$0.0, $0.1] = .Living
                }
            }
        }
    }
    
    var emptyColor:UIColor = UIColor(red:250/255, green:250/255,blue: 250/255, alpha:1)
    var livingColor:UIColor = UIColor.redColor().colorWithAlphaComponent(0)
    var bornColor:UIColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
    var diedColor1:UIColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.6)
    var gridColor:UIColor = UIColor.blackColor()
    var gridWidth:CGFloat = 1.0
    
    
    override func drawRect(rect: CGRect)
    {
        let rows = StandardEngine.sharedInstance.rows
        let cols = StandardEngine.sharedInstance.cols
        
        
        for rw in 0..<rows
        {
            for cl in 0..<cols
            {
                
                var path = UIBezierPath(ovalInRect: CGRectMake(CGFloat(cl)*(bounds.width/CGFloat(cols))+CGFloat(gridWidth/2), CGFloat(rw)*(bounds.height/CGFloat(rows))+CGFloat(gridWidth/2), bounds.width/CGFloat(cols)-CGFloat(gridWidth), bounds.height/CGFloat(rows)-CGFloat(gridWidth)))
                
                let shinePath = UIBezierPath(ovalInRect: CGRectMake((CGFloat(cl)*(bounds.width/CGFloat(cols))+CGFloat(gridWidth/2))+(bounds.width/CGFloat(cols)-CGFloat(gridWidth))*CGFloat(0.6), CGFloat(rw)*(bounds.height/CGFloat(rows))+CGFloat(gridWidth/2)+(bounds.height/CGFloat(rows)-CGFloat(gridWidth))*CGFloat(0.2), (bounds.width/CGFloat(cols)-CGFloat(gridWidth))/CGFloat(4), (bounds.height/CGFloat(rows)-CGFloat(gridWidth))/CGFloat(4)))
                
                var xFace:Bool = false
                var bornFace:Bool = false
                var livingFace:Bool = false
                var predatorFace:Bool = false
                
                switch StandardEngine.sharedInstance.grid[rw,cl]
                {
                case .Living :
                    livingColor.setFill()
                    livingFace = true
                case .Born :
                    bornColor.setFill()
                    bornFace = true
                case .Died :
                    xFace = true
                    diedColor1.setFill()
                case .Predator:
                    predatorFace = true
                    UIColor.blackColor().setFill()
                default:
                    path = UIBezierPath(rect:CGRectMake(CGFloat(cl)*(bounds.width/CGFloat(cols))+CGFloat(gridWidth/2), CGFloat(rw)*(bounds.height/CGFloat(rows))+CGFloat(gridWidth/2), bounds.width/CGFloat(cols)-CGFloat(gridWidth), bounds.height/CGFloat(rows)-CGFloat(gridWidth)))
                    emptyColor.setFill()
                }
                path.fill()
                
                //drawing the faces
                if faces == true
                {
                    if xFace == true
                    {
                        let xPath = UIBezierPath()
                        xPath.lineWidth = CGFloat(1.0)
                        xPath.moveToPoint(CGPoint(x:path.bounds.minX + path.bounds.width/CGFloat(5), y:path.bounds.minY + path.bounds.height/CGFloat(2.7)))
                        xPath.addLineToPoint(CGPoint(x:path.bounds.minX + path.bounds.width/CGFloat(2.4), y:path.bounds.minY + path.bounds.height/CGFloat(1.5)))
                    
                        xPath.moveToPoint(CGPoint(x:path.bounds.minX + path.bounds.width*CGFloat(0.8), y:path.bounds.minY + path.bounds.height/CGFloat(1.5)))
                        xPath.addLineToPoint(CGPoint(x:path.bounds.minX + path.bounds.width*CGFloat(1.0-1.0/2.4), y:path.bounds.minY + path.bounds.height/CGFloat(2.7)))
                        
                        xPath.moveToPoint(CGPoint(x:path.bounds.minX + path.bounds.width*CGFloat(0.8), y:path.bounds.minY + path.bounds.height/CGFloat(2.7)))
                        xPath.addLineToPoint(CGPoint(x:path.bounds.minX + path.bounds.width*CGFloat(1.0-1.0/2.4), y:path.bounds.minY + path.bounds.height/CGFloat(1.5)))
                    
                        xPath.moveToPoint(CGPoint(x:path.bounds.minX + path.bounds.width/CGFloat(5), y:path.bounds.minY + path.bounds.height/CGFloat(1.5)))
                        xPath.addLineToPoint(CGPoint(x:path.bounds.minX + path.bounds.width/CGFloat(2.4), y:path.bounds.minY + path.bounds.height/CGFloat(2.7)))
                        xPath.moveToPoint(CGPoint(x:path.bounds.minX + path.bounds.width/CGFloat(2.7), y:path.bounds.minY + path.bounds.height/CGFloat(1.25)))
                        xPath.addLineToPoint(CGPoint(x:path.bounds.minX + path.bounds.width*CGFloat(1.0-1.0/2.8), y:path.bounds.minY + path.bounds.height/CGFloat(1.25)))
                    
                        UIColor.whiteColor().colorWithAlphaComponent(0.9).setStroke()
                        xPath.stroke()
                    }
                    
                    if bornFace == true
                    {
                        let epath = UIBezierPath()
                        epath.moveToPoint(CGPoint(x:path.bounds.minX + path.bounds.width/CGFloat(4), y:path.bounds.minY + path.bounds.height/CGFloat(2.1)))
                        epath.addLineToPoint(CGPoint(x:path.bounds.minX + path.bounds.width/CGFloat(4), y:path.bounds.minY + path.bounds.height/CGFloat(2.1) + path.bounds.width/6))
                        
                        epath.moveToPoint(CGPoint(x:path.bounds.maxX - path.bounds.width/CGFloat(4), y:path.bounds.minY + path.bounds.height/CGFloat(2.1)))
                        epath.addLineToPoint(CGPoint(x:path.bounds.maxX - path.bounds.width/CGFloat(4), y:path.bounds.minY + path.bounds.height/CGFloat(2.1) + path.bounds.width/6))
                        UIColor.whiteColor().colorWithAlphaComponent(0.9).setStroke()
                        epath.stroke()
 
                        
                        let sucker = UIBezierPath(ovalInRect:CGRectMake(path.bounds.midX - path.bounds.width/6, path.bounds.midY + path.bounds.height/10, path.bounds.width/3, path.bounds.height/3))
                        UIColor.whiteColor().colorWithAlphaComponent(0.9).setFill()
                        sucker.fill()
                        
                        let ring = UIBezierPath(ovalInRect:CGRectMake(sucker.bounds.midX - sucker.bounds.width/2.6, sucker.bounds.midY - sucker.bounds.height/10, sucker.bounds.width/1.3, sucker.bounds.height/1.5))
                        UIColor.orangeColor().setStroke()
                        ring.stroke()

                        
                    }
                    
                    if livingFace == true
                    {
                        let epath = UIBezierPath()
                        epath.moveToPoint(CGPoint(x:path.bounds.minX + path.bounds.width/CGFloat(4), y:path.bounds.minY + path.bounds.height/CGFloat(2.1)))
                        epath.addLineToPoint(CGPoint(x:path.bounds.minX + path.bounds.width/CGFloat(4), y:path.bounds.minY + path.bounds.height/CGFloat(2.1) + path.bounds.width/6))
                        
                        epath.moveToPoint(CGPoint(x:path.bounds.maxX - path.bounds.width/CGFloat(4), y:path.bounds.minY + path.bounds.height/CGFloat(2.1)))
                        epath.addLineToPoint(CGPoint(x:path.bounds.maxX - path.bounds.width/CGFloat(4), y:path.bounds.minY + path.bounds.height/CGFloat(2.1) + path.bounds.width/6))
                       
                        UIColor.whiteColor().colorWithAlphaComponent(0.9).setStroke()
                        epath.stroke()
                        
                        let smile = UIBezierPath()
                        smile.moveToPoint(CGPoint(x:path.bounds.midX + path.bounds.width/6.7, y:path.bounds.minY + path.bounds.height*0.4 + path.bounds.height/3.5))
                        smile.addArcWithCenter(CGPoint(x:path.bounds.midX-0.2, y:path.bounds.minY + path.bounds.height*0.4), radius: path.bounds.width/3, startAngle: CGFloat(M_PI/2)-0.5, endAngle: CGFloat(M_PI/2)+0.5, clockwise:  true)
                        smile.stroke()
                    }
                    
                    if predatorFace == true
                    {
                        let circleCenter = CGPointMake(path.bounds.minX + path.bounds.width/3.3, path.bounds.minY + path.bounds.height/2)
                        let circleRadius = min(path.bounds.width/5.5, path.bounds.height/5.5)
                        let start = CGFloat(2.3 * M_PI/2)
                        let end = start - CGFloat(M_PI)
                        let circlePath = UIBezierPath(arcCenter: circleCenter, radius: circleRadius, startAngle: start, endAngle: end, clockwise: false)
                        UIColor(red:220/255, green: 0, blue:0, alpha:1).setFill()
                        circlePath.fill()
                        
                        let circleCenter2 = CGPointMake(path.bounds.maxX - path.bounds.width/3.3, path.bounds.maxY - path.bounds.height/2)
                        let circleRadius2 = min(path.bounds.width/5.5, path.bounds.height/5.5)
                        let start2 = CGFloat(1.7 * M_PI/2)
                        let end2 = start2 + CGFloat(M_PI)
                        let circlePath2 = UIBezierPath(arcCenter: circleCenter2, radius: circleRadius2, startAngle: start2, endAngle: end2, clockwise: false)
                        UIColor(red:220/255, green: 0, blue:0, alpha:1).setFill()
                        circlePath2.fill()
                        
                        
                        let teeth = UIBezierPath()
                        teeth.moveToPoint(CGPoint(x:path.bounds.minX + path.bounds.width/CGFloat(3.1), y:path.bounds.minY + path.bounds.height/CGFloat(1.25)))
                        teeth.addLineToPoint(CGPoint(x:path.bounds.minX + path.bounds.width/CGFloat(3.1) + path.bounds.width/30, y:path.bounds.minY + path.bounds.height/CGFloat(1.16) + path.bounds.height/15))
                        teeth.addLineToPoint(CGPoint(x:path.bounds.minX + path.bounds.width/CGFloat(3.1) + path.bounds.width/15, y:path.bounds.minY + path.bounds.height/CGFloat(1.25)))
                        
                        teeth.moveToPoint(CGPoint(x:path.bounds.maxX - path.bounds.width/CGFloat(3.1), y:path.bounds.minY + path.bounds.height/CGFloat(1.25)))
                        teeth.addLineToPoint(CGPoint(x:path.bounds.maxX - path.bounds.width/CGFloat(3.1) - path.bounds.width/30, y:path.bounds.minY + path.bounds.height/CGFloat(1.16) + path.bounds.height/15))
                        teeth.addLineToPoint(CGPoint(x:path.bounds.maxX - path.bounds.width/CGFloat(3.1) - path.bounds.width/15, y:path.bounds.minY + path.bounds.height/CGFloat(1.25)))
                        
                        UIColor.whiteColor().setFill()
                        teeth.fill()
                        
                        let mouth = UIBezierPath()
                        mouth.lineWidth = CGFloat(1.0)
                        mouth.moveToPoint(CGPoint(x:path.bounds.minX + path.bounds.width/CGFloat(3.1), y:path.bounds.minY + path.bounds.height/CGFloat(1.25)))
                        mouth.addLineToPoint(CGPoint(x:path.bounds.minX + path.bounds.width*CGFloat(1.0-1.0/3.1), y:path.bounds.minY + path.bounds.height/CGFloat(1.25)))
                        UIColor.whiteColor().setStroke()
                        mouth.stroke()
                    }
                }
                
                switch StandardEngine.sharedInstance.grid[rw,cl]
                {
                case .Living,.Born:
                    UIColor.whiteColor().colorWithAlphaComponent(0.9).setFill()
                case .Predator:
                    UIColor.whiteColor().colorWithAlphaComponent(0.6).setFill()

                default:
                    UIColor.whiteColor().colorWithAlphaComponent(0).setFill()
                }
                
                if Shine == true
                {
                    shinePath.fill()
                }
            }
        }
        
        for r in 0...rows
        {
            let horizontalPath = UIBezierPath()
            horizontalPath.moveToPoint(CGPoint(x:0, y:CGFloat(r)*bounds.height/CGFloat(rows)))
            horizontalPath.addLineToPoint(CGPoint(x:bounds.width, y:CGFloat(r)*bounds.height/CGFloat(rows)))
            horizontalPath.closePath()
            gridColor.set()
            horizontalPath.lineWidth = gridWidth
            horizontalPath.stroke()
            horizontalPath.fill()
        }
        
        for c in 0...cols
        {
            let verticalPath = UIBezierPath()
            verticalPath.moveToPoint(CGPoint(x:CGFloat(c)*bounds.width/CGFloat(cols), y:0))
            verticalPath.addLineToPoint(CGPoint(x:CGFloat(c)*bounds.width/CGFloat(cols), y:bounds.height))
            verticalPath.closePath()
            gridColor.set()
            verticalPath.lineWidth = gridWidth
            verticalPath.stroke()
            verticalPath.fill()
        }
    }
    
    func changed(before:GridProtocol, after:GridProtocol)
    {
        let rows = StandardEngine.sharedInstance.rows
        let cols = StandardEngine.sharedInstance.cols
        for r in 0..<rows
        {
            for c in 0..<cols
            {
                if before[r,c] != after[r,c]
                {
                    self.setNeedsDisplayInRect(CGRectMake(CGFloat(c)*bounds.width/CGFloat(cols), CGFloat(r)*bounds.height/CGFloat(rows), bounds.width/CGFloat(cols), bounds.height/CGFloat(rows)))
                }
            }
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        
        let rows = StandardEngine.sharedInstance.rows
        let cols = StandardEngine.sharedInstance.cols
        
        if let touch = touches.first
        {
            let point = touch.locationInView(self)
            StandardEngine.sharedInstance.grid[Int(point.y/(bounds.height/CGFloat(rows))),Int(point.x/(bounds.width/CGFloat(cols)))] = StandardEngine.sharedInstance.grid[Int(point.y/(bounds.height/CGFloat(rows))),Int(point.x/(bounds.width/CGFloat(cols)))].toggle(StandardEngine.sharedInstance.grid[Int(point.y/(bounds.height/CGFloat(rows))),Int(point.x/(bounds.width/CGFloat(cols)))])
            
            setNeedsDisplayInRect(CGRectMake(CGFloat(Int(point.x/(bounds.width/CGFloat(cols))))*(bounds.width/CGFloat(cols)),CGFloat(Int(point.y/(bounds.height/CGFloat(rows))))*(bounds.height/CGFloat(rows)), bounds.width/CGFloat(cols), bounds.height/CGFloat(rows)))
            
            lastPoint = (Int(point.y/(bounds.height/CGFloat(rows))),Int(point.x/(bounds.width/CGFloat(cols))))
            
            NSNotificationCenter.defaultCenter().postNotificationName("Engine rc notification", object: nil, userInfo: nil)
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        let rows = StandardEngine.sharedInstance.rows
        let cols = StandardEngine.sharedInstance.cols
        
        if let touch = touches.first
        {
            let point = touch.locationInView(self)
            if lastPoint != (Int(point.y/(bounds.height/CGFloat(rows))),Int(point.x/(bounds.width/CGFloat(cols)))) && point.x < self.bounds.maxX && point.y < self.bounds.maxY && point.x > self.bounds.minX && point.y > self.bounds.minY
            {
                StandardEngine.sharedInstance.grid[Int(point.y/(bounds.height/CGFloat(rows))),Int(point.x/(bounds.width/CGFloat(cols)))] = StandardEngine.sharedInstance.grid[Int(point.y/(bounds.height/CGFloat(rows))),Int(point.x/(bounds.width/CGFloat(cols)))].toggle(StandardEngine.sharedInstance.grid[Int(point.y/(bounds.height/CGFloat(rows))),Int(point.x/(bounds.width/CGFloat(cols)))])
            
                setNeedsDisplayInRect(CGRectMake(CGFloat(Int(point.x/(bounds.width/CGFloat(cols))))*(bounds.width/CGFloat(cols)),CGFloat(Int(point.y/(bounds.height/CGFloat(rows))))*(bounds.height/CGFloat(rows)), bounds.width/CGFloat(cols), bounds.height/CGFloat(rows)))
            
                NSNotificationCenter.defaultCenter().postNotificationName("Engine rc notification", object: nil, userInfo: nil)
                lastPoint = (Int(point.y/(bounds.height/CGFloat(rows))),Int(point.x/(bounds.width/CGFloat(cols))))
            }
        }
        
    }
    
}
