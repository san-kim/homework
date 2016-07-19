//
//  protocols.swift
//  Assignment3
//
//  Created by Kiwook Kim on 7/14/16.
//  Copyright © 2016 sankim. All rights reserved.
//

import Foundation

protocol GridProtocol:class
{
    init(rows:Int, cols:Int)
    var rows : Int {get}
    var cols : Int {get}
    func neighbors(coords:(row:Int,col:Int)) -> [(Int,Int)]
    subscript(row:Int, col:Int) -> CellState { get set }
}


protocol EngineDelegate
{
    func engineDidUpdate(withGrid:GridProtocol)
}

protocol EngineProtocol
{
    var delegate:EngineDelegate? {get set}
    var grid:GridProtocol {get}
    var refreshRate:Double {get set}
    var refreshTimer:NSTimer? {get set}
    var rows:Int {get set}
    var cols:Int {get set}
    init(rows:Int, cols:Int)
    func step() -> GridProtocol
}

extension EngineProtocol
{
    var refreshRate:Double
    {
        return 0.0
    }
}