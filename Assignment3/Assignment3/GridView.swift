//
//  GridView.swift
//  Assignment3
//
//  Created by Kiwook Kim on 7/9/16.
//  Copyright © 2016 sankim. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class GridView: UIView
{
    var grid = [[CellState]]()
    
    @IBInspectable var rows:Int = 20
    {
        
        didSet
        {//USE NEWVALUE AND OLDVALUE, CLEAR THE 2-D ARRAY,
            for r in 0..<grid.count
            {
                for c in 0..<grid[r].count
                {
                    grid[r][c] = .Empty
                }
            }
        }
    }
    
    @IBInspectable var cols:Int = 20
    {
        didSet
        {
            for r in 0..<grid.count
            {
                for c in 0..<grid[0].count
                {
                    grid[r][c] = .Empty
                }
            }
        }
    }
    

    
    @IBInspectable var livingColor:UIColor = UIColor.greenColor()
    @IBInspectable var emptyColor:UIColor = UIColor.darkGrayColor()
    @IBInspectable var bornColor:UIColor = UIColor.greenColor().colorWithAlphaComponent(0.6)
    @IBInspectable var diedColor:UIColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.6)
    @IBInspectable var gridColor:UIColor = UIColor.blackColor()
    @IBInspectable var gridWidth:CGFloat = 2.0
    
    //self-note: also doable by UIColor(red: , green: , blue: , alpha: )
    var initialize:Bool = true
    
    override func drawRect(rect: CGRect)
    {
        if initialize == true
        {
            for r in 0..<rows
            {
                grid.append([CellState]())
                for _ in 0..<cols
                {
                    grid[r].append(.Empty)
                }
            }
            initialize = false
        }
        
        for rw in 0..<rows
        {
            for cl in 0..<cols
            {
                let path = UIBezierPath(ovalInRect: CGRectMake(CGFloat(cl)*(bounds.width/CGFloat(cols))+CGFloat(gridWidth/2), CGFloat(rw)*(bounds.height/CGFloat(rows))+CGFloat(gridWidth/2), bounds.width/CGFloat(cols)-CGFloat(gridWidth), bounds.height/CGFloat(rows)-CGFloat(gridWidth)))
               
                switch grid[rw][cl]
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
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if let touch = touches.first
        {
            let point = touch.locationInView(self)
            grid[Int(point.y/(bounds.height/CGFloat(rows)))][Int(point.x/(bounds.width/CGFloat(cols)))] = grid[Int(point.y/(bounds.height/CGFloat(rows)))][Int(point.x/(bounds.width/CGFloat(cols)))].toggle(grid[Int(point.y/(bounds.height/CGFloat(rows)))][Int(point.x/(bounds.width/CGFloat(cols)))])
            setNeedsDisplayInRect(CGRectMake(CGFloat(Int(point.x/(bounds.width/CGFloat(cols))))*(bounds.width/CGFloat(cols)),CGFloat(Int(point.y/(bounds.height/CGFloat(rows))))*(bounds.height/CGFloat(rows)), bounds.width/CGFloat(cols), bounds.height/CGFloat(rows)))
        }
    }
    
}
