//
//  RunButton.swift
//  Assignment3
//
//  Created by Kiwook Kim on 7/11/16.
//  Copyright © 2016 sankim. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class runButton:UIButton
{
    @IBInspectable var color = UIColor.greenColor()

    override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?)
    {
        print("HI")
        for item in presses
        {
            if item.type == UIPressType.Select
            {
                print("worke")
                self.color = UIColor.greenColor()
            }
        }
    }

    
}