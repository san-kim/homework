//
//  GridView.swift
//  FinalProject
//
//  Created by Kiwook Kim on 7/25/16.
//  Copyright © 2016 sankim. All rights reserved.
//

import Foundation
import UIKit

class BackgroundView: UIView
{
    var livingColor1:UIColor = UIColor(red:120/255, green:0/255, blue: 0/255, alpha:1)
    var livingColor2:UIColor = UIColor.redColor()
    var gridWidth:CGFloat = 1.0
    
    
    override func drawRect(rect: CGRect)
    {
        if red == true
        {
            livingColor1 = UIColor(red:120/255, green:0/255,blue: 0/255, alpha:1)
            livingColor2 = UIColor.redColor()
        }
        else if orange == true
        {
            livingColor1 = UIColor(red:255/255, green:65/255,blue: 0/255, alpha:1)
            livingColor2 = UIColor(red:255/255, green:182/255,blue: 181/255, alpha:1)
        }
        else if green == true
        {
            livingColor1 = UIColor(red:43/255, green:127/255,blue: 80/255, alpha:1)
            livingColor2 = UIColor(red:41/255, green:255/255,blue: 0/255, alpha:1)
        }
        else if blue == true
        {
            livingColor1 = UIColor(red:15/255.0, green:118/255.0, blue:128/255.0, alpha:1)
            livingColor2 = UIColor(red:119/255.0, green:239/255.0, blue:255/255.0, alpha:1)
        }
        else if purple == true
        {
            livingColor1 = UIColor(red:75/255, green:0/255,blue: 128/255, alpha:1)
            livingColor2 = UIColor(red:164/255, green:223/255,blue: 255/255, alpha:1)
        }
        
        let rows = StandardEngine.sharedInstance.rows
        let cols = StandardEngine.sharedInstance.cols
                
        for rw in 0..<rows
        {
            for cl in 0..<cols
            {
                
                let path = UIBezierPath(ovalInRect: CGRectMake(CGFloat(cl)*(bounds.width/CGFloat(cols))+CGFloat(gridWidth/2), CGFloat(rw)*(bounds.height/CGFloat(rows))+CGFloat(gridWidth/2), bounds.width/CGFloat(cols)-CGFloat(gridWidth), bounds.height/CGFloat(rows)-CGFloat(gridWidth)))
                
                let gradient:CAGradientLayer = CAGradientLayer()
                gradient.frame = path.bounds
                gradient.locations = [0.0, 1.0]
                gradient.colors = [livingColor1.CGColor, livingColor2.CGColor]
                self.layer.addSublayer(gradient)
                
                let rectBezierPath = UIBezierPath(rect:CGRectMake(CGFloat(cl)*(bounds.width/CGFloat(cols))+CGFloat(gridWidth/2), CGFloat(rw)*(bounds.height/CGFloat(rows))+CGFloat(gridWidth/2), bounds.width/CGFloat(cols)-CGFloat(gridWidth), bounds.height/CGFloat(rows)-CGFloat(gridWidth)))
                rectBezierPath.appendPath(path)
                //rectBezierPath.setUsesEvenOddFillRule = true
                
                let fillLayer = CAShapeLayer()
                fillLayer.path = rectBezierPath.CGPath
                fillLayer.fillRule = kCAFillRuleEvenOdd
                fillLayer.fillColor = UIColor.whiteColor().CGColor
                self.layer.addSublayer(fillLayer)
            }
        }
    }
}
