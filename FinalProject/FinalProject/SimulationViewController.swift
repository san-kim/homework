//
//  SecondViewController.swift
//  FinalProject
//
//  Created by Kiwook Kim on 7/25/16.
//  Copyright © 2016 sankim. All rights reserved.
//
//  <div>Icons made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>

import UIKit
var PPB:Bool = false

class SimulationViewController: UIViewController, EngineDelegate
{
    
    private var inputTextField: UITextField?
    weak var AddAlertSaveAction: UIAlertAction?
    
    @IBOutlet var gridV: GridView!

    @IBOutlet var clearblueBackground: UIView!

    
    @IBOutlet var background: BackgroundView!
    
    @IBAction func runB(sender: UIButton)
    {
        StandardEngine.sharedInstance.grid = StandardEngine.sharedInstance.step()
        NSNotificationCenter.defaultCenter().postNotificationName("Engine rc notification", object: nil, userInfo: nil)
    }
    
    @IBOutlet var pausePlayButton: PPButton!
    
    @IBAction func PPBPressed(sender: AnyObject)
    {
        StandardEngine.sharedInstance.isPaused = !StandardEngine.sharedInstance.isPaused
        
        NSNotificationCenter.defaultCenter().postNotificationName("changeTimedRefresh", object: nil, userInfo: nil)
        pausePlayButton.setNeedsDisplay()
    }
    
    @IBAction func saveButton(sender: AnyObject)
    {
        
        //stop the grid from changing while still in the save view
        StandardEngine.sharedInstance.refreshTimer?.invalidate()
        
        let alert = UIAlertController(title: "Save", message: "Please enter a name to save the current grid", preferredStyle: UIAlertControllerStyle.Alert)
        
        //set up the function to remove the observer
        func removeTextFieldObserver() {
            NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: alert.textFields![0])
        }
        
        //add cancel button action
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
            removeTextFieldObserver()
            if !StandardEngine.sharedInstance.isPaused{
                StandardEngine.sharedInstance.refreshInterval = NSTimeInterval(StandardEngine.sharedInstance.refreshRate)
            }
            if let delegate = StandardEngine.sharedInstance.delegate {
                delegate.engineDidUpdate(StandardEngine.sharedInstance.grid)
            }
            
        }))
        
        //set up save button actino to use later
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: {(action) -> Void in
            if let text = self.inputTextField!.text{
                TableListViewController.sharedTable.gridNames.append(text)
                TableListViewController.sharedTable.comments.append("")
                
                if let point = GridView().points{
                    var medium:[[Int]] = []
                    _ = point.map{ medium.append([$0.0, $0.1]) }
                    TableListViewController.sharedTable.gridItemCoordinates.append(medium)
                }
                
                let itemRow = TableListViewController.sharedTable.gridNames.count - 1
                let itemPath = NSIndexPath(forRow:itemRow, inSection: 0)
                TableListViewController().tableView.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
                NSNotificationCenter.defaultCenter().postNotificationName("TableViewReloadData", object: nil, userInfo: nil)
            }
            removeTextFieldObserver()
            
            if !StandardEngine.sharedInstance.isPaused{
                StandardEngine.sharedInstance.refreshInterval = NSTimeInterval(StandardEngine.sharedInstance.refreshRate)
            }
            if let delegate = StandardEngine.sharedInstance.delegate
            {
                delegate.engineDidUpdate(StandardEngine.sharedInstance.grid)
            }
            
        })
        
        //disable the save button initially unless the user enters any text
        saveAction.enabled = false
        
        AddAlertSaveAction = saveAction
        
        //add save button
        alert.addAction(saveAction)
        
        //add a text field for user to enter name for the row
        alert.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Enter name:"
            self.inputTextField = textField
            //add observer
            let sel = #selector(self.handleTextFieldTextDidChangeNotification(_:))
            NSNotificationCenter.defaultCenter().addObserver(self, selector: sel, name: UITextFieldTextDidChangeNotification, object: textField)
        })
        
        //pop up the alert view
        self.presentViewController(alert, animated: true, completion: nil)

    }
 
    
    func handleTextFieldTextDidChangeNotification(notification: NSNotification) {
        let textField = notification.object as! UITextField
        
        // Enforce a minimum length of >= 1 for secure text alerts.
        if let text = textField.text{
            AddAlertSaveAction!.enabled = text.characters.count >= 1
        }
    }

    
    
    @IBAction func ResetButtonPressed(sender: AnyObject)
    {
        StandardEngine.sharedInstance.grid = StandardEngine.sharedInstance.reset()
        NSNotificationCenter.defaultCenter().postNotificationName("Engine rc notification", object: nil, userInfo: nil)
    }
    
    
    func engineDidUpdate(withGrid: GridProtocol)
    {
        //gridV.changed(before, after: StandardEngine.sharedInstance.grid)
        gridV.setNeedsDisplay()
        
        if backgroundChange == true
        {
            //most likely to either change all the colors or the rows and cols of the background, so must reset the whole background
            background.setNeedsDisplay()
            backgroundChange = false
        }
        
        if faces == true
        {
            gridV.setNeedsDisplay()
        }
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let c = NSNotificationCenter.defaultCenter()
        let s = #selector(SimulationViewController.watchForNotifications(_:))
        c.addObserver(self, selector: s, name: "switchChangedFromINS", object: nil)
        
        StandardEngine.sharedInstance.delegate = self
        gridV.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(0)
    }
    
    func watchForNotifications(notification:NSNotification)
    {
        pausePlayButton.setNeedsDisplay()
    }
        
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
}

