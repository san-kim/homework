//
//  ViewController.swift
//  Assignment3
//
//  Created by Kiwook Kim on 7/9/16.
//  Copyright © 2016 sankim. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController
{
    
    @IBOutlet var gridV: GridView!
    @IBAction func runB(sender: runButton)
    {
        let myEngine = engine()
        var after:[[CellState]] = myEngine.step(gridV.grid)
        for r in 0..<gridV.rows
        {
            for c in 0..<gridV.cols
            {
                gridV.grid[r][c] = after[r][c]
            }
        }
        
        gridV.setNeedsDisplay()
 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

