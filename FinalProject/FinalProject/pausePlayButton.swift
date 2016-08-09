//
//  pausePlayButton.swift
//  FinalProject
//
//  Created by Kiwook Kim on 7/30/16.
//  Copyright © 2016 sankim. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable class PPButton:UIButton
{
    @IBInspectable var background:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
    
    
    override func drawRect(rect: CGRect)
    {
        let backgroundCircle = UIBezierPath(ovalInRect: CGRectMake(rect.minX, rect.minY, rect.width, rect.height))
        background.setFill()
        backgroundCircle.fill()
        
        if StandardEngine.sharedInstance.isPaused == true
        {
            let button = UIBezierPath()
            button.moveToPoint(CGPoint(x: rect.minX + rect.width/3, y: rect.minY + rect.height/4))
            button.addLineToPoint(CGPoint(x: rect.minX + rect.width/3 + rect.width/4*1.732, y:rect.maxY/2))
            button.addLineToPoint(CGPoint(x:rect.minX + rect.width/3, y:rect.maxY - rect.height/4))
            button.closePath()
            UIColor.darkGrayColor().setFill()
            button.fill()
        }
        
        if StandardEngine.sharedInstance.isPaused == false
        {
            let button1 = UIBezierPath(rect:CGRectMake(rect.minX + rect.width/3.3, rect.minY + rect.height/3.5, rect.width/8, rect.height/2.3))
            let button2 = UIBezierPath(rect:CGRectMake(rect.maxX - rect.width/3.3 - rect.width/8, rect.minY + rect.height/3.5, rect.width/8, rect.height/2.3))
            UIColor.darkGrayColor().setFill()
            button1.fill()
            button2.fill()
        }
    }
}

 