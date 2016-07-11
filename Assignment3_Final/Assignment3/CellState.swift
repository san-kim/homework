//
//  CellState.swift
//  Assignment3
//
//  Created by Kiwook Kim on 7/9/16.
//  Copyright © 2016 sankim. All rights reserved.
//

import Foundation
import UIKit

    enum CellState: String
    {
        case Living = "Living"
        case Empty = "Empty"
        case Born = "Born"
        case Died = "Died"
        
        
        func description(expression:CellState) -> String
        {
            switch expression
            {
                case .Living:
                    return "Living"
                case .Empty:
                    return "Empty"
                case .Born:
                    return "Born"
                default:
                    return "Died"
                
            }
        }
        
        static func allValues() -> [CellState]
        {
            return ([.Living, .Empty, .Born, .Died])
        }
        
        
        func toggle(value:CellState)-> CellState
        {
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

