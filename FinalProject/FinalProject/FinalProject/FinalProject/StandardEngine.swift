//
//  StandardEngine.swift
//  FinalProject
//
//  Created by Kiwook Kim on 7/25/16.
//  Copyright © 2016 sankim. All rights reserved.
//

import Foundation
import UIKit

var before:GridProtocol = Grid(StandardEngine.sharedInstance.rows, StandardEngine.sharedInstance.cols)

class StandardEngine:EngineProtocol
{
    var changed:Bool = false
    private static var SI = StandardEngine(10,10)
    static var sharedInstance: StandardEngine
    {
        get
        {
            return SI
        }
    }
    
    var delegate: EngineDelegate?
    var grid: GridProtocol
    var refreshTimer: NSTimer?
    //in class we discussed how we weren't going to give protocols with defaults, so the default implementation is here
    var isPaused:Bool = true;
    var refreshRate: Double = 0
    var refreshInterval:NSTimeInterval=0
        {
        didSet
        {
            if refreshInterval != 0
            {
                if let timer = refreshTimer{timer.invalidate()}
                let sel = #selector(StandardEngine.timerDidFire(_:))
                refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refreshInterval, target: self, selector: sel, userInfo: nil, repeats: true)
            }
                
            else if let timer = refreshTimer
            {
                timer.invalidate()
                self.refreshTimer = nil
            }
        }
    }
    
    var rows: Int = 10
    {
        didSet {
            grid = Grid(self.rows, self.cols) { _,_ in .Empty }
            if let delegate = delegate { delegate.engineDidUpdate(grid) }
        }
    }
    
    var cols: Int = 10
    {
        didSet {
            grid = Grid(self.rows, self.cols) { _,_ in .Empty }
            if let delegate = delegate { delegate.engineDidUpdate(grid) }
        }
    }
    
    init(_ rows: Int, _ cols: Int, cellInitializer: CellInitializer = {_ in .Empty }) {
        self.rows = rows
        self.cols = cols
        self.grid = Grid(rows,cols, cellInit: cellInitializer)
    }
    
    func reset() -> GridProtocol
    {
        var after:GridProtocol = Grid(rows,cols)
        for row in 0..<rows
        {
            for col in 0..<cols
            {
                after[row,col] = .Empty
            }
        }
        
        if let delegate = StandardEngine.sharedInstance.delegate
        {
            delegate.engineDidUpdate(StandardEngine.sharedInstance.grid)
        }
        
        return after
    }
    
    func step() -> GridProtocol
    {
        var after:GridProtocol = Grid(self.rows, self.cols)
        before = StandardEngine.sharedInstance.grid
        
        
        after.cells = grid.cells.map
        {
            switch grid.livingNeighbors($0.position)
            {
            case 2 where $0.state.isLiving(), 3 where $0.state.isLiving():
                return Cell($0.position, .Living)
            case 3 where !$0.state.isLiving():
                return Cell($0.position, .Born)
            case _ where $0.state.isLiving():
                return Cell($0.position, .Died)
            default:
                return Cell($0.position, .Empty)
            }
        }
        
        if let delegate = delegate
        {
            delegate.engineDidUpdate(after)
        }
        
        grid = after
        
        return after
        
    }
    
    
    @objc func timerDidFire(timer:NSTimer)
    {
        StandardEngine.sharedInstance.grid = StandardEngine.sharedInstance.step()
        NSNotificationCenter.defaultCenter().postNotificationName("Engine rc notification", object: nil, userInfo: nil)
        
    }
    
    subscript (i:Int, j:Int) -> CellState {
        get {
            return grid.cells[i*cols+j].state
        }
        set {
            grid.cells[i*cols+j].state = newValue
        }
    }
}


