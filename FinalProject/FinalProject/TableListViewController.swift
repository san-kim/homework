//
//  TableListViewController.swift
//  FinalProject
//
//  Created by Kiwook Kim on 7/29/16.
//  Copyright © 2016 sankim. All rights reserved.
//

//  <div>Icons made by <a href="http://www.flaticon.com/authors/iconnice" title="Iconnice">Iconnice</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>

import Foundation
import UIKit

class TableListViewController:UITableViewController
{
    var gridNames:[String] = ["Pulsar","Magical","Spaceship"]
    //just some cool preset grids
    var gridItemCoordinates:[[[Int]]] = [[[6,4],[7,4],[8,4],[12,4],[13,4],[14,4],[6,4],[6,16],[7,16],[8,16],[12,16],[13,16],[14,16],[6,16],[4,6],[4,7],[4,8],[4,12],[4,13],[4,14],[16,6],[16,7],[16,8],[16,12],[16,13],[16,14],[6,9],[7,9],[8,9],[6,11],[7,11],[8,11],[6,9],[7,9],[8,9],[6,11],[7,11],[8,11],[12,9],[13,9],[14,9],[12,11],[13,11],[14,11],[9,6],[9,7],[9,8],[11,6],[11,7],[11,8],[9,12],[9,13],[9,14],[11,12],[11,13],[11,14]],[[5,10],[6,10],[7,9],[7,11],[8,10],[9,10],[10,10],[11,10],[12,9],[12,11],[13,10],[14,10]],[[0,0],[0,3],[1,4],[2,0],[2,4],[3,1],[3,2],[3,3],[3,4]]]
    var comments:[String] = ["This is a Pulsating grid","Dumbledore made this magical pattern","This spaceship is really FLY :-)"]
    
    static var _sharedT = TableListViewController()
    static var sharedTable: TableListViewController { get {return _sharedT} }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let sel = #selector(TableListViewController.dataReload(_:))
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: sel, name: "TableViewReloadData", object: nil)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func dataReload(notification:NSNotification)
    {
        self.tableView.reloadData()
        self.tableView.setNeedsDisplay()
    }
    
    @IBAction func addButton(sender: AnyObject)
    {
    
        TableListViewController.sharedTable.gridNames.append("Add new name")
        TableListViewController.sharedTable.gridItemCoordinates.append([])
        TableListViewController.sharedTable.comments.append("")

        
        let itemRow = TableListViewController.sharedTable.gridNames.count - 1
        let itemPath = NSIndexPath(forRow:itemRow, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
        
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return TableListViewController.sharedTable.gridNames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("Default")
        else
        {
                preconditionFailure("missing Default reuse identifier")
        }
        
        let row = indexPath.row
        guard let nameLabel = cell.textLabel
        else
        {
            preconditionFailure("Something is wrong.")
        }
        
        nameLabel.text = TableListViewController.sharedTable.gridNames[row]
        cell.tag = row
        return cell
    }
    
    // HEADS UP: when putting in the url, the app adds a " " space to it
    @IBOutlet var urlTextField: UITextField!
    
    @IBAction func tryButton(sender: AnyObject)
    {
        //TableListViewController.sharedTable.gridNames = []
        //TableListViewController.sharedTable.gridItemCoordinates = []
        
        var s:String? = urlTextField.text!

        //delete the extra space at the very end of the url when pasted
        if ((urlTextField.text?.containsString(" ")) != nil)
        {
            s = s!.stringByReplacingOccurrencesOfString(" ", withString: "")
        }
        
        //if the user enters an invalid url, pop up an alert view
        if let url = s{
            guard let requestURL: NSURL = NSURL(string: url) else {
                let alertController = UIAlertController(title: "URL Error", message:
                    "Please enter a valid url!", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(urlRequest) {
                (data, response, error) -> Void in
                
                let httpResponse = response as?NSHTTPURLResponse
                let statusCode = httpResponse?.statusCode
                if let safeStatusCode = statusCode{
                    if (safeStatusCode == 200) {
                        do{
                            let json = try NSJSONSerialization.JSONObjectWithData(data!, options:.AllowFragments) as? [AnyObject]
                            for i in 0...json!.count-1 {
                                let pattern = json![i]
                                let collection = pattern as! Dictionary<String, AnyObject>
                                TableListViewController.sharedTable.gridNames.append(collection["title"]! as! String)
                                let arr = collection["contents"].map{return $0 as! [[Int]]}
                                TableListViewController.sharedTable.gridItemCoordinates.append(arr!)
                            }
                            TableListViewController.sharedTable.comments = TableListViewController.sharedTable.gridNames.map{_ in return ""}
                        }catch {
                            print("Error with Json: \(error)")
                        }
                        
                        //put the table reload process into the main thread to reload it right away
                        let op = NSBlockOperation {
                            NSNotificationCenter.defaultCenter().postNotificationName("TableViewReloadData", object: nil, userInfo: nil)
                        }
                        NSOperationQueue.mainQueue().addOperation(op)
                        
                    }
                    else{
                        //put the pop up window in the main thread for HTTP errors and then pop it up
                        
                        let op = NSBlockOperation {
                            let alertController = UIAlertController(title: "Error", message:
                                "HTTP Error \(safeStatusCode): \(NSHTTPURLResponse.localizedStringForStatusCode(safeStatusCode))           Please enter a valid url", preferredStyle: UIAlertControllerStyle.Alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                            
                            self.presentViewController(alertController, animated: true, completion: nil)
                        }
                        NSOperationQueue.mainQueue().addOperation(op)
                    }
                }else{
                    //put the pop up window in the main thread for url errors and then pop it up
                    let op = NSBlockOperation {
                        let alertController = UIAlertController(title: "Error", message:
                            "Please check your url or your Internet connection", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                    NSOperationQueue.mainQueue().addOperation(op)
                }
            }
            task.resume()
        }


    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        StandardEngine.sharedInstance.changed = false
        let editingRow = (sender as! UITableViewCell).tag
        let editingString = TableListViewController.sharedTable.gridNames[editingRow]
        let editingDescription = TableListViewController.sharedTable.comments[editingRow]
        guard let editingVC = segue.destinationViewController as? GridEditViewController
            else {
                preconditionFailure("Something went wrong")
        }
        editingVC.name = editingString
        editingVC.describe = editingDescription
        editingVC.commit = {
            TableListViewController.sharedTable.gridNames[editingRow] = $0
            let indexPath = NSIndexPath(forRow: editingRow, inSection: 0)
            self.tableView.reloadRowsAtIndexPaths([indexPath],
                                                  withRowAnimation: .Automatic)
        }
        editingVC.gridCommit = {
            TableListViewController.sharedTable.gridItemCoordinates[editingRow] = $0
        }
        
        editingVC.commitForDescription = {
            TableListViewController.sharedTable.comments[editingRow] = $0
        }
       
        let max = TableListViewController.sharedTable.gridItemCoordinates[editingRow].flatMap{$0}.maxElement()
        if let safeMax = max
        {
            StandardEngine.sharedInstance.rows = (safeMax % 10 != 0) ? (safeMax/10+1)*10 : safeMax
            StandardEngine.sharedInstance.cols = (safeMax % 10 != 0) ? (safeMax/10+1)*10 : safeMax
        }
        
        //set the cells on
        let medium:[(Int,Int)] = TableListViewController.sharedTable.gridItemCoordinates[editingRow].map{return ($0[0], $0[1])}
        GridView().points = medium
        
        //update grid in simulation tab
        if let delegate = StandardEngine.sharedInstance.delegate {
            backgroundChange = true
            delegate.engineDidUpdate(StandardEngine.sharedInstance.grid)
        }
        
        //update the text fields of row and col in the instrumentation tab
        NSNotificationCenter.defaultCenter().postNotificationName("updateGrid2View", object: nil, userInfo: nil)
        
        NSNotificationCenter.defaultCenter().postNotificationName("updateRowAndColText", object: nil, userInfo: nil)
        
        NSNotificationCenter.defaultCenter().postNotificationName("pauseAndSetMPoff", object: nil, userInfo: nil)
        
    }
}

