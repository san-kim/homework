//
//  Grid.swift
//  FinalProject
//
//  Created by Kiwook Kim on 7/25/16.
//  Copyright © 2016 sankim. All rights reserved.
//

import Foundation
import UIKit

class Grid:GridProtocol
{
    var rows : Int
    var cols : Int
    
    private var grid:[[CellState]]
    required init(rows:Int, cols:Int)
    {
        self.rows = rows
        self.cols = cols
        grid = [[CellState]](count:rows, repeatedValue:[CellState](count:cols, repeatedValue: CellState.Empty))
    }
    
    func neighbors(coord:(row:Int, col:Int)) -> [(Int,Int)]
    {
        var arr = [(Int,Int)]()
        arr.append((coord.row+1,coord.col+1))
        arr.append((coord.row+1,coord.col))
        arr.append((coord.row+1,coord.col-1))
        arr.append((coord.row,coord.col-1))
        arr.append((coord.row,coord.col+1))
        arr.append((coord.row-1,coord.col-1))
        arr.append((coord.row-1,coord.col))
        arr.append((coord.row-1,coord.col+1))
        return arr
    }
    
    subscript(row:Int, col:Int) -> CellState
        {
        get
        {
            return grid[row][col]
        }
        
        set(newValue)
        {
            grid[row][col] = newValue
        }
    }
}