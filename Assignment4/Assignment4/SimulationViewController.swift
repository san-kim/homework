//
//  SecondViewController.swift
//  Assignment4
//
//  Created by Kiwook Kim on 7/12/16.
//  Copyright © 2016 sankim. All rights reserved.
//
//icons courtesy of Icon8

import UIKit

class SimulationViewController: UIViewController, EngineDelegate
{
    
    @IBOutlet var gridV: GridView!
    
    @IBAction func runB(sender: UIButton)
    {
        StandardEngine.sharedInstance.grid = StandardEngine.sharedInstance.step()
        NSNotificationCenter.defaultCenter().postNotificationName("Engine rc notification", object: nil, userInfo: ["value":StandardEngine.sharedInstance.grid])
    }
    
    func engineDidUpdate(withGrid: GridProtocol)
    {
        gridV.setNeedsDisplay()
        //gridV.changed(before, after:StandardEngine.sharedInstance.grid)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        StandardEngine.sharedInstance.delegate = self
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

}

