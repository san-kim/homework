//
//  gradientBackgrounds.swift
//  FinalProject
//
//  Created by Kiwook Kim on 7/27/16.
//  Copyright © 2016 sankim. All rights reserved.
//  code modified from Nate and raywenderlich.com

import Foundation
import UIKit

@IBDesignable class gradientBackground:UIView
{
    @IBInspectable var top:UIColor = UIColor(red:95/255.0, green:158/255.0, blue:160/255.0, alpha:1)
    @IBInspectable var bot:UIColor = UIColor(red:176/255.0, green:224/255.0, blue:230/255.0, alpha:0.5)
    
    //let top = UIColor(red:130/255.0, green:179/255.0, blue:217/255.0, alpha:1)
    //let bot = UIColor(red:240/255.0, green:248/255.0, blue:255/255.0, alpha:0.5)
    
    override func drawRect(rect: CGRect)
    {
        let gradientColors:[CGColor] = [top.CGColor, bot.CGColor]
        let gradientLocations:[Float] = [0.0,1.0]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, atIndex: 0)
    }

}
