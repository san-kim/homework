//
//  Grid.swift
//  FinalProject
//
//  Created by Kiwook Kim on 7/25/16.
//  Copyright © 2016 sankim. All rights reserved.
//

import Foundation
import UIKit



struct Grid:GridProtocol
{
    private(set) var rows : Int
    private(set) var cols : Int
    var cells:[Cell]
    
    var live: Int { return cells.reduce(0) { return  $1.state.isLiving() ?  $0 + 1 : $0 } }
    var dead: Int { return cells.reduce(0) { return !$1.state.isLiving() ?  $0 + 1 : $0 } }
    var living: Int { return cells.reduce(0) { return  $1.state == .Living  ?  $0 + 1 : $0 } }
    var born:   Int { return cells.reduce(0) { return  $1.state == .Born   ?  $0 + 1 : $0 } }
    var died:   Int { return cells.reduce(0) { return  $1.state == .Died   ?  $0 + 1 : $0 } }
    var empty:  Int { return cells.reduce(0) { return  $1.state == .Empty  ?  $0 + 1 : $0 } }
    
    init(_ rows:Int,_ cols:Int, cellInit:CellInitializer = {_ in .Empty })
    {
        self.rows = rows
        self.cols = cols
        self.cells = (0..<rows*cols).map {
            let pos = Position($0/cols, $0%cols)
            return Cell(pos, cellInit(pos))
        }
    }
    
    private static let offsets:[Position] = [(-1,-1),(0,-1),(1,-1),(1,0),(-1,0),(-1,1),(0,1),(1,1),]
    
    func neighbors(pos:Position) -> [Position]
    {
        return Grid.offsets.map { Position((pos.row + rows + $0.row) % rows,
            (pos.col + cols + $0.col) % cols) }
    }
    
    subscript (row:Int, col:Int) -> CellState {
        get {
            return cells[row*cols+col].state
        }
        set {
            cells[row*cols+col].state = newValue
        }
    }
    
    func livingNeighbors(position: Position) -> Int {
        return neighbors(position)
            .reduce(0) {
                self[$1.row,$1.col].isLiving() ? $0 + 1 : $0
        }
    }
}
