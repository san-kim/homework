//
//  GridView.swift
//  Assignment4
//
//  Created by Kiwook Kim on 7/17/16.
//  Copyright © 2016 sankim. All rights reserved.
//


import Foundation
import UIKit

 class GridView: UIView
{
     var livingColor:UIColor = UIColor.greenColor()
     var emptyColor:UIColor = UIColor.darkGrayColor()
     var bornColor:UIColor = UIColor.greenColor().colorWithAlphaComponent(0.6)
     var diedColor:UIColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.6)
     var gridColor:UIColor = UIColor.blackColor()
     var gridWidth:CGFloat = 2.0
    
    
    
    override func drawRect(rect: CGRect)
    {
        let rows = StandardEngine.sharedInstance.rows
        let cols = StandardEngine.sharedInstance.cols
        
        for rw in 0..<rows
        {
            for cl in 0..<cols
            {
                
                let path = UIBezierPath(ovalInRect: CGRectMake(CGFloat(cl)*(bounds.width/CGFloat(cols))+CGFloat(gridWidth/2), CGFloat(rw)*(bounds.height/CGFloat(rows))+CGFloat(gridWidth/2), bounds.width/CGFloat(cols)-CGFloat(gridWidth), bounds.height/CGFloat(rows)-CGFloat(gridWidth)))
                
                switch StandardEngine.sharedInstance.grid[rw,cl]
                {
                case .Living :
                    livingColor.setFill()
                case .Born :
                    bornColor.setFill()
                case .Died :
                    diedColor.setFill()
                default:
                    emptyColor.setFill()
                    
                }
                path.fill()
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
    
    func changed(before:[[CellState]], after:GridProtocol)
    {
        let rows = StandardEngine.sharedInstance.rows
        let cols = StandardEngine.sharedInstance.cols
        for r in 0..<rows
        {
            for c in 0..<cols
            {
                if before[r][c] != after[r,c]
                {
                    setNeedsDisplayInRect(CGRectMake(CGFloat(c)*bounds.width/CGFloat(cols), CGFloat(r)*bounds.height/CGFloat(rows), bounds.width/CGFloat(cols), bounds.height/CGFloat(rows)))
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
            
            NSNotificationCenter.defaultCenter().postNotificationName("Engine rc notification", object: nil, userInfo: ["value":StandardEngine.sharedInstance.grid])
        }

    }
    
}
