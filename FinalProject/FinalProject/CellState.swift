//
//  CellState.swift
//  FinalProject
//
//  Created by Kiwook Kim on 7/25/16.
//  Copyright © 2016 sankim. All rights reserved.
//

import Foundation
import UIKit

enum CellState: String
{
    case Living
    case Empty
    case Born
    case Died
    case Predator
    
    func isLiving() -> Bool
    {
        switch self
        {
            case .Living,.Born:
                return true
            case .Died, .Empty, .Predator:
                return false
        }
    }
    
    func toggle(value:CellState)-> CellState
    {
        StandardEngine.sharedInstance.changed = true
        if value == .Living || value == .Born
        {
            return .Empty
        }
            
        else
        {
            return .Living
        }
    }
}

