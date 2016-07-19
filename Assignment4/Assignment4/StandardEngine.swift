//
//  StandardEngine.swift
//  Assignment4
//
//  Created by Kiwook Kim on 7/17/16.
//  Copyright © 2016 sankim. All rights reserved.
//

import Foundation

class StandardEngine:EngineProtocol
{
    private static var SI = StandardEngine(rows:10, cols:10)
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
    
    var rows: Int
    {
        didSet
        {
            StandardEngine.sharedInstance.rows = rows
            if let delegate = delegate
            {
                delegate.engineDidUpdate(grid)
            }
            NSNotificationCenter.defaultCenter().postNotificationName("Engine rc notification", object: self, userInfo: ["value" : grid])
        }
    }
    
    var cols: Int
    {
        didSet
        {
            StandardEngine.sharedInstance.cols = cols
            if let delegate = delegate
            {
                delegate.engineDidUpdate(grid)
            }
            NSNotificationCenter.defaultCenter().postNotificationName("Engine rc notification", object: nil, userInfo: ["value":grid])
        }
    }
    
    required init(rows:Int, cols:Int)
    {
        self.rows = rows
        self.cols = cols
        grid = Grid(rows: rows,cols: cols)
        
    }
    

    func step() -> GridProtocol
    {
        let after:GridProtocol = Grid(rows: rows, cols: cols)
        
        for row in 0..<rows
        {
            for col in 0..<cols
            {
                var counterA = 0
                var counterD = 0
                let H = rows
                let W = cols
                
                //the modulas does the "wrapping," the +H assures that no negative values are passed
                
                let nbs = grid.neighbors((row,col))
                for index in 0..<8
                {
                    if grid[(nbs[index].0+H)%H,(nbs[index].1+W)%W] == .Living || grid[(nbs[index].0+H)%H,(nbs[index].1+W)%W] == .Born
                    {
                        if grid[row,col] == .Living || grid[row,col] == .Born
                        {
                            counterA += 1
                        }
                        else if grid[row,col] == .Died || grid[row,col] == .Empty
                        {
                            counterD += 1
                        }
                    }
                }

                
                 switch grid[row,col]
                 {
                    case .Died, .Empty :
                        if counterD == 3
                        {
                            after[row,col] = .Born
                        }
                        else 
                        {
                            after[row,col] = .Empty
                        }
                 
                    case .Living, .Born :
                        if counterA < 2 || counterA > 3
                        {
                            after[row,col] = .Died
                        }
                        else
                        {
                            after[row,col] = .Living
                        }
                 }

            }
        }
        
        if let delegate = StandardEngine.sharedInstance.delegate
        {
            delegate.engineDidUpdate(StandardEngine.sharedInstance.grid)
        }
        
        return after

    }
    
    
    @objc func timerDidFire(timer:NSTimer)
    {
        StandardEngine.sharedInstance.grid = StandardEngine.sharedInstance.step()
        NSNotificationCenter.defaultCenter().postNotificationName("Engine rc notification", object: nil, userInfo: ["value":grid])

    }
}

class gridProtocolChangedNotification
{
    let myGridP: GridProtocol
    init(s:GridProtocol)
    {
        myGridP = s
    }
}

