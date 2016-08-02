//
//  GridEditViewController.swift
//  FinalProject
//
//  Created by Kiwook Kim on 7/29/16.
//  Copyright © 2016 sankim. All rights reserved.
//

import Foundation
import UIKit
class GridEditViewController: UIViewController,EngineDelegate
{
    var name:String?
    var describe:String?
    var commit: (String -> Void)?
    var commitForDescription: (String -> Void)?
    var gridCommit: ([[Int]] -> Void)?
    var savedCells: [[Int]] = []
    
    @IBOutlet var gridV2: GridView!
    @IBOutlet var background2: BackgroundView!
    
    @IBAction func displayPressed(sender: AnyObject)
    {
        self.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func cancelB(sender: AnyObject)
    {
        if StandardEngine.sharedInstance.changed
        {
            
            let alert = UIAlertController(title: "Quit Without Saving", message: "Are you sure you want to quit without saving?", preferredStyle: UIAlertControllerStyle.Alert)
            //add cancel button alert
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Quit", style: UIAlertActionStyle.Default, handler: {(action) -> Void in self.navigationController!.popViewControllerAnimated(true)}))
            
            let op = NSBlockOperation {
                self.presentViewController(alert, animated: true, completion: nil)
            }
            NSOperationQueue.mainQueue().addOperation(op)
        }
        else
        {
            navigationController!.popViewControllerAnimated(true)
        }
        //clear the changes detecter
        StandardEngine.sharedInstance.changed = false
    }
    
    @IBOutlet var nameText: UITextField!
    
    @IBAction func commentHappened(sender: AnyObject)
    {
        StandardEngine.sharedInstance.changed = true
    }
   
    @IBAction func saved(sender: AnyObject)
    {
        let filteredArray = StandardEngine.sharedInstance.grid.cells.filter{$0.state.isLiving()}.map{return $0.position}
        
        for i in filteredArray{
            savedCells.append([i.row, i.col])
        }
        
        guard let newText = nameText.text, commit = commit
            else { return }
        commit(newText)
        guard let anothercommit = gridCommit else { return }
        anothercommit(savedCells)
        
        navigationController!.popViewControllerAnimated(true)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridV2.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(0)
        background2.setNeedsDisplay()
        gridV2.setNeedsDisplay()
        nameText.text = name
     
        //set up the observer which updates the grid in the embed view when gets called
        let sel = #selector(GridEditViewController.watchForNotifications(_:))
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: sel, name: "updateGrid2View", object: nil)
    }
    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func watchForNotifications(notification:NSNotification)
    {
        background2.setNeedsDisplay()
        gridV2.setNeedsDisplay()
    }
 
    
    func engineDidUpdate(withGrid: GridProtocol)
    {
        gridV2.setNeedsDisplay()
        background2.setNeedsDisplay()
        
        if backgroundChange2 == true
        {
            //most likely to either change all the colors or the rows and cols of the background, so must reset the whole background
            background2.setNeedsDisplay()
            backgroundChange2 = false
        }
        
        if faces == true
        {
            gridV2.setNeedsDisplay()
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    

}