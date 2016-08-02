//
//  Protocols.swift
//  FinalProject
//
//  Created by Kiwook Kim on 7/25/16.
//  Copyright © 2016 sankim. All rights reserved.
//

import UIKit
import Foundation

typealias Position = (row:Int, col: Int)
typealias Cell = (position: Position, state: CellState)
typealias CellInitializer = (Position) -> CellState

protocol GridProtocol
{
    var rows : Int {get}
    var cols : Int {get}
    var cells:[Cell] {get set}
    
    var live: Int { get }
    var dead: Int { get }
    var living:  Int { get }
    var born:   Int { get }
    var died:   Int { get }
    var empty:  Int { get }
    
    func neighbors(pos:Position) -> [Position]
    subscript(row:Int, col:Int) -> CellState { get set }
    func livingNeighbors(position:Position) -> Int
}


protocol EngineDelegate:class
{
    func engineDidUpdate(withGrid:GridProtocol)
}

protocol EngineProtocol
{
    weak var delegate:EngineDelegate? {get set}
    var grid:GridProtocol {get}
    var refreshRate:Double {get set}
    var refreshTimer:NSTimer? {get set}
    var rows:Int {get set}
    var cols:Int {get set}
    func step() -> GridProtocol
}

extension EngineProtocol
{
    var refreshRate:Double
    {
        return 0.0
    }
}