//
//  SecondViewController.swift
//  FinalProject
//
//  Created by Kiwook Kim on 7/25/16.
//  Copyright © 2016 sankim. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegate
{
    @IBOutlet var gridV: GridView! 

    @IBOutlet var background: BackgroundView!
    
    @IBAction func runB(sender: UIButton)
    {
        StandardEngine.sharedInstance.grid = StandardEngine.sharedInstance.step()
        NSNotificationCenter.defaultCenter().postNotificationName("Engine rc notification", object: nil, userInfo: ["value":StandardEngine.sharedInstance.grid])
    }
    
    @IBAction func ResetButtonPressed(sender: AnyObject)
    {
        StandardEngine.sharedInstance.grid = StandardEngine.sharedInstance.reset()
        NSNotificationCenter.defaultCenter().postNotificationName("Engine rc notification", object: nil, userInfo: ["value":StandardEngine.sharedInstance.grid])
    }
    
    
    func engineDidUpdate(withGrid: GridProtocol)
    {
        gridV.setNeedsDisplay()
        if backgroundChange == true
        {
            background.setNeedsDisplay()
            backgroundChange = false
        }
        
        if faces == true
        {
            gridV.setNeedsDisplay()
        }
        
        //gridV.changed(before, after:StandardEngine.sharedInstance.grid)
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        StandardEngine.sharedInstance.delegate = self
        gridV.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(0)
    }
        
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
 
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        background.setNeedsDisplay()
    }
    
 }

