//
//  StatisticsViewController.swift
//  FinalProject
//
//  Created by Kiwook Kim on 7/25/16.
//  Copyright © 2016 sankim. All rights reserved.
//
//  <div>Icons made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>

import Foundation
import UIKit
class StatisticsViewController: UIViewController {
    
    @IBOutlet var LivingText: UILabel!
    @IBOutlet var BornText: UILabel!
    @IBOutlet var DiedText: UILabel!
    @IBOutlet var EmptyText: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        LivingText.clipsToBounds = true
        BornText.clipsToBounds = true;
        DiedText.clipsToBounds = true;
        EmptyText.clipsToBounds = true;
        
        var livingC = 0
        var bornC = 0
        var diedC = 0
        var emptyC = 0
        
        let grid = StandardEngine.sharedInstance.grid
        let cols = grid.cols
        let rows = grid.rows
        
        for r in 0..<rows
        {
            for c in 0..<cols
            {
                if grid[r,c] == .Living
                {livingC += 1}
                else if grid[r,c] == .Born
                {bornC += 1}
                else if grid[r,c] == .Died
                {diedC += 1}
                else if grid[r,c] == .Empty
                {emptyC += 1}
            }
        }
        
        LivingText.text = String(livingC)
        BornText.text = String(bornC)
        DiedText.text = String(diedC)
        EmptyText.text = String(emptyC)
        
        let sel = #selector(StatisticsViewController.watchForNotifications(_:))
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: sel, name: "Engine rc notification", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func watchForNotifications(notification:NSNotification)
    {
        var livingC = 0
        var bornC = 0
        var diedC = 0
        var emptyC = 0
        
        let grid = StandardEngine.sharedInstance.grid
        let cols = grid.cols
        let rows = grid.rows
        
        for r in 0..<rows
        {
            for c in 0..<cols
            {
                if grid[r,c] == .Living
                {livingC += 1}
                else if grid[r,c] == .Born
                {bornC += 1}
                else if grid[r,c] == .Died
                {diedC += 1}
                else if grid[r,c] == .Empty
                {emptyC += 1}
            }
        }
        
        LivingText.text = String(livingC)
        BornText.text = String(bornC)
        DiedText.text = String(diedC)
        EmptyText.text = String(emptyC)
        
    }
    
}

