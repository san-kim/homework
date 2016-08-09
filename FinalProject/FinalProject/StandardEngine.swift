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
var predatorCounter = 0
var horizontalPredator = false
var randomRow:UInt32 = 0
var randomCol:UInt32 = 0

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
        
        //just the predator and mutation cases: mutation--random row and col turned on to .Born every 10 rounds, predator--every 15+(rows or cols) rounds, a new predator appears which moves either horizontally or vertically right/down  the grid, "eating" all 8 cells around it as it goes
        if mutate==true && arc4random_uniform(10) == 6
        {
            let randomRow = arc4random_uniform(UInt32(StandardEngine.sharedInstance.rows))
            let randomCol = arc4random_uniform(UInt32(StandardEngine.sharedInstance.cols))
            after[Int(randomRow),Int(randomCol)] = .Born
        }
        
        
        if predator == true && predatorCounter != 0 && horizontalPredator == true && predatorCounter<=StandardEngine.sharedInstance.cols
        {
            after[Int(randomRow),predatorCounter-1] = .Empty
            after[Int(randomRow),predatorCounter] = .Predator
            let nebs = after.neighbors((Int(randomRow),predatorCounter-1))
            for index in 0..<8
            {
                if after[nebs[index].0, nebs[index].1] == .Born || after[nebs[index].0, nebs[index].1] == .Living {after[nebs[index].0, nebs[index].1] = .Died}
            }
            predatorCounter += 1
            predatorCounter = predatorCounter%StandardEngine.sharedInstance.cols
        }
        
        if predator == true && predatorCounter != 0 && horizontalPredator == false && predatorCounter<=StandardEngine.sharedInstance.rows
        {
            after[predatorCounter-1,Int(randomCol)] = .Empty
            after[predatorCounter,Int(randomCol)] = .Predator
            let nebs = after.neighbors((predatorCounter-1,Int(randomCol)))
            for index in 0..<8
            {
                if after[nebs[index].0, nebs[index].1] == .Born || after[nebs[index].0, nebs[index].1] == .Living {after[nebs[index].0, nebs[index].1] = .Died}
            }
            predatorCounter += 1
            predatorCounter = predatorCounter%StandardEngine.sharedInstance.rows
        }
        
        if predator==true && arc4random_uniform(15) == 3 && predatorCounter == 0
        {
            randomRow = arc4random_uniform(UInt32(StandardEngine.sharedInstance.rows))
            randomCol = arc4random_uniform(UInt32(StandardEngine.sharedInstance.cols))
            let VH = arc4random_uniform(2)
            let nebs = after.neighbors((Int(randomRow),Int(randomCol)))
            
            if VH == 0
            {
                horizontalPredator = true
                after[Int(randomRow),0] = .Predator
                for index in 0..<8
                {
                    if after[nebs[index].0, nebs[index].1] == .Born || after[nebs[index].0, nebs[index].1] == .Living {after[nebs[index].0, nebs[index].1] = .Died}
                }
            }
            
            else
            {
                horizontalPredator = false
                after[0,Int(randomCol)] = .Predator
                for index in 0..<8
                {
                    if after[nebs[index].0, nebs[index].1] == .Born || after[nebs[index].0, nebs[index].1] == .Living {after[nebs[index].0, nebs[index].1] = .Died}
                }
            }
            predatorCounter += 1
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


