//
//  FirstViewController.swift
//  FinalProject
//
//  Created by Kiwook Kim on 7/25/16.
//  Copyright © 2016 sankim. All rights reserved.
//
//  <div>Icons made by <a href="http://www.flaticon.com/authors/gregor-cresnar" title="Gregor Cresnar">Gregor Cresnar</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>




// Talked to the Professor, and he said that I could make the table viewcontroller a separate tab, as I do not have enough space on the instrumentation, with all my features, to accomodate a table that takes up half the screen

import UIKit
var backgroundChange:Bool = false
var backgroundChange2:Bool = false
var Shine:Bool = true
var faces:Bool = true

var red:Bool = true
var orange:Bool = false
var green:Bool = false
var blue:Bool = false
var purple:Bool = false
var black:Bool = false

class InstrumentationViewController: UIViewController
{
    var delegate: EngineDelegate?

    @IBOutlet var label1: UILabel!
    @IBOutlet var stepper1: UIStepper!
    @IBAction func stepper1changed(sender: UIStepper)
    {
        StandardEngine.sharedInstance.rows = Int(stepper1.value)
        label1.text = String(Int(stepper1.value))
        backgroundChange = true
        backgroundChange2 = true
        StandardEngine.sharedInstance.grid = Grid(StandardEngine.sharedInstance.rows, StandardEngine.sharedInstance.cols)
        NSNotificationCenter.defaultCenter().postNotificationName("updateGrid2View", object: nil, userInfo: nil)
    }
    
    @IBOutlet var stepper2: UIStepper!
    @IBOutlet var label2: UILabel!
    @IBAction func stepper2changed(sender: UIStepper)
    {
        StandardEngine.sharedInstance.cols = Int(stepper2.value)
        label2.text = String(Int(stepper2.value))
        backgroundChange = true
        backgroundChange2 = true
        StandardEngine.sharedInstance.grid = Grid(StandardEngine.sharedInstance.rows, StandardEngine.sharedInstance.cols)
        NSNotificationCenter.defaultCenter().postNotificationName("updateGrid2View", object: nil, userInfo: nil)
    }
    
    @IBOutlet var label3: UILabel!
    @IBOutlet var slider: UISlider!
    @IBAction func sliderchanged(sender: UISlider)
    {
        StandardEngine.sharedInstance.refreshInterval = NSTimeInterval(slider.value)
        
        //this is so that if slider is moved from the 0 position, then it gets turned on, if put in the 0 position, it gets turned off, and to display "0" and "10" instead of "0.0" or "10.0" - the minimum and max

        if slider.value > 0
        {
            switchbutton.setOn(true, animated: true)
            StandardEngine.sharedInstance.isPaused = false
            NSNotificationCenter.defaultCenter().postNotificationName("switchChangedFromINS", object: nil, userInfo: nil)
            if slider.value == 10.0
            {
                label3.text = "10"
            }
            else
            {
                label3.text = String(Double(Int(slider.value*10))/10)
            }
        }
        
        else if slider.value == 0
        {
            switchbutton.setOn(false, animated: true)
            StandardEngine.sharedInstance.isPaused = true
            label3.text = "0"
            NSNotificationCenter.defaultCenter().postNotificationName("switchChangedFromINS", object: nil, userInfo: nil)
        }

    }
    
    @IBOutlet var switchbutton: UISwitch!
    

    @IBAction func switchchanged(sender: AnyObject)
    {
        if switchbutton.on
        {
            //to set the min value of 0.1 if the slider is 0 when the timed switch is turned on
            if slider.value == 0
            {
                label3.text = "0.1"
                slider.value = 0.1
            }
            
            StandardEngine.sharedInstance.isPaused = false
            StandardEngine.sharedInstance.refreshInterval = NSTimeInterval(slider.value)
        }
        else
        {
            //to set the slider value to 0 if the timed switch is turned off
            if slider.value != 0
            {
                label3.text = "0"
                slider.value = 0
            }
            StandardEngine.sharedInstance.isPaused = true
            StandardEngine.sharedInstance.refreshTimer?.invalidate()
        }
        NSNotificationCenter.defaultCenter().postNotificationName("switchChangedFromINS", object: nil, userInfo: nil)
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().postNotificationName("updateGrid2View", object: nil, userInfo: nil)
        let c = NSNotificationCenter.defaultCenter()
        let s = #selector(InstrumentationViewController.watchForNotifications(_:))
        c.addObserver(self, selector: s, name: "updateRowAndColText", object: nil)
        
        let sel = #selector(InstrumentationViewController.changeTimedRefresh(_:))
        c.addObserver(self, selector: sel, name: "changeTimedRefresh", object: nil)
        
        NSNotificationCenter.defaultCenter().postNotificationName("Engine rc notification", object: nil, userInfo: nil)
    }
    
    func changeTimedRefresh(notification:NSNotification)
    {
        if StandardEngine.sharedInstance.isPaused == true
        {
            switchbutton.setOn(false, animated: true)
            StandardEngine.sharedInstance.refreshTimer?.invalidate()
        }
        
        else
        {
            switchbutton.setOn(true, animated: true)
            if slider.value == 0
            {
                label3.text = "0.2"
                slider.value = 0.2
            }
            StandardEngine.sharedInstance.refreshInterval = NSTimeInterval(slider.value)
        }
    }
    
    
    func watchForNotifications(notification:NSNotification)
    {
        stepper1.value = Double(StandardEngine.sharedInstance.rows)
        stepper2.value = Double(StandardEngine.sharedInstance.cols)
        label1.text = String(Int(StandardEngine.sharedInstance.cols))
        label2.text = String(Int(StandardEngine.sharedInstance.rows))
    }
    
    
    
    
    //switch that controls the "shine" glisten effect for each grid cell for the 3-D effect
    @IBOutlet var shineSW: UISwitch!
    @IBAction func shineSwitchChanged(sender: UISwitch)
    {
        if shineSW.on
        {
            Shine = true
        }
        else
        {
            Shine = false
        }
        //just to send the notification
        StandardEngine.sharedInstance.delegate?.engineDidUpdate(StandardEngine.sharedInstance.grid)
    }
    
    @IBOutlet var faceSwitch: UISwitch!
    @IBAction func faceSwitchChanged(sender: UISwitch)
    {
        if faceSwitch.on
        {
            faces = true
        }
        else
        {
            faces = false
        }
        //just to send the notification
        StandardEngine.sharedInstance.delegate?.engineDidUpdate(StandardEngine.sharedInstance.grid)
    }
    
    @IBOutlet var rd: PushButtonView!
    @IBAction func redPushed(sender: AnyObject)
    {
        //for some reason the check didn't show, so this is just a forceful/the only way of making the color conform to the if statement
        rd.color = UIColor(red:190/255, green:0/255,blue: 0/255, alpha:1)
        
        red = true
        orange = false
        green = false
        blue = false
        purple = false
        black = false
        
        rd.setNeedsDisplay()
        or.setNeedsDisplay()
        gr.setNeedsDisplay()
        bl.setNeedsDisplay()
        pr.setNeedsDisplay()
        bk.setNeedsDisplay()

        //just to send the notification
        backgroundChange = true
        backgroundChange2 = true
        StandardEngine.sharedInstance.delegate?.engineDidUpdate(StandardEngine.sharedInstance.grid)
    }

    
    @IBOutlet var or: PushButtonView!
    @IBAction func orangePushed(sender: UIButton)
    {
        or.color = UIColor(red:255/255, green:133/255,blue: 84/255, alpha:1)
        
        red = false
        orange = true
        green = false
        blue = false
        purple = false
        black = false
        
        rd.setNeedsDisplay()
        gr.setNeedsDisplay()
        bl.setNeedsDisplay()
        pr.setNeedsDisplay()
        or.setNeedsDisplay()
        bk.setNeedsDisplay()
        
        //just to send the notification
        backgroundChange = true
        backgroundChange2 = true
        StandardEngine.sharedInstance.delegate?.engineDidUpdate(StandardEngine.sharedInstance.grid)
    }
    
    @IBOutlet var gr: PushButtonView!
    @IBAction func greenPushed(sender: UIButton)
    {
        gr.color = UIColor(red:60/255, green:179/255,blue: 113/255, alpha:1)
        
        red = false
        orange = false
        green = true
        blue = false
        purple = false
        black = false
        
        rd.setNeedsDisplay()
        or.setNeedsDisplay()
        gr.setNeedsDisplay()
        bl.setNeedsDisplay()
        pr.setNeedsDisplay()
        bk.setNeedsDisplay()
        
        //just to send the notification
        backgroundChange = true
        backgroundChange2 = true
        StandardEngine.sharedInstance.delegate?.engineDidUpdate(StandardEngine.sharedInstance.grid)
    }
    

    @IBOutlet var bl: PushButtonView!
    @IBAction func bluePressed(sender: UIButton)
    {
        bl.color = UIColor(red:35/255, green:126/255,blue: 212/255, alpha:1)
        
        red = false
        orange = false
        green = false
        blue = true
        purple = false
        black = false
        
        rd.setNeedsDisplay()
        or.setNeedsDisplay()
        gr.setNeedsDisplay()
        bl.setNeedsDisplay()
        pr.setNeedsDisplay()
        bk.setNeedsDisplay()
        
        //just to send the notification
        backgroundChange = true
        backgroundChange2 = true
        StandardEngine.sharedInstance.delegate?.engineDidUpdate(StandardEngine.sharedInstance.grid)
    }
    

    @IBOutlet var pr: PushButtonView!
    @IBAction func purplePressed(sender: UIButton)
    {
        pr.color = UIColor(red:85/255, green:44/255,blue: 165/255, alpha:1)
        
        red = false
        orange = false
        green = false
        blue = false
        purple = true
        black = false
        
        rd.setNeedsDisplay()
        or.setNeedsDisplay()
        gr.setNeedsDisplay()
        bl.setNeedsDisplay()
        pr.setNeedsDisplay()
        bk.setNeedsDisplay()
        
        //just to send the notification
        backgroundChange = true
        backgroundChange2 = true
        StandardEngine.sharedInstance.delegate?.engineDidUpdate(StandardEngine.sharedInstance.grid)

    }

    
    @IBOutlet var bk: PushButtonView!
    @IBAction func blackPressed(sender: UIButton)
    {
        bk.color = UIColor(red:71/255, green:71/255,blue: 71/255, alpha:1)
        
        red = false
        orange = false
        green = false
        blue = false
        purple = false
        black = true
        
        rd.setNeedsDisplay()
        or.setNeedsDisplay()
        gr.setNeedsDisplay()
        bl.setNeedsDisplay()
        pr.setNeedsDisplay()
        bk.setNeedsDisplay()
        
        //just to send the notification
        backgroundChange = true
        backgroundChange2 = true
        StandardEngine.sharedInstance.delegate?.engineDidUpdate(StandardEngine.sharedInstance.grid)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

