//
//  goToButton.swift
//  FinalProject
//
//  Created by Kiwook Kim on 8/2/16.
//  Copyright © 2016 sankim. All rights reserved.
//

import Foundation
import UIKit

class goToButton: UIButton
{
    override func drawRect(rect: CGRect)
    {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: rect.width/2 - rect.height/8*1.732 + rect.width/20, y: rect.minY + rect.height/4))
        path.addLineToPoint(CGPoint(x: rect.minX + rect.width/3 + rect.height/4*1.732 + rect.width/20, y:rect.maxY/2))
        path.addLineToPoint(CGPoint(x:rect.width/2 - rect.height/8*1.732 + rect.width/20, y:rect.maxY - rect.height/4))
        path.closePath()
        UIColor.darkGrayColor().setStroke()
        path.stroke()
    }
}


