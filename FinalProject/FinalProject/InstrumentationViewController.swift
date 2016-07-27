//
//  FirstViewController.swift
//  FinalProject
//
//  Created by Kiwook Kim on 7/25/16.
//  Copyright © 2016 sankim. All rights reserved.
//
//icons courtesy of Icon8


import UIKit
var backgroundChange:Bool = false
var Shine:Bool = true
var faces:Bool = false

var red:Bool = true
var orange:Bool = false
var green:Bool = false
var blue:Bool = false
var purple:Bool = false

class InstrumentationViewController: UIViewController
{
    @IBOutlet var label1: UILabel!
    @IBOutlet var stepper1: UIStepper!
    @IBAction func stepper1changed(sender: UIStepper)
    {
        StandardEngine.sharedInstance.rows = Int(stepper1.value)
        label1.text = String(Int(stepper1.value))
        backgroundChange = true
        StandardEngine.sharedInstance.grid = Grid(rows: StandardEngine.sharedInstance.rows, cols: StandardEngine.sharedInstance.cols)
    }
    
    @IBOutlet var stepper2: UIStepper!
    @IBOutlet var label2: UILabel!
    @IBAction func stepper2changed(sender: UIStepper)
    {
        StandardEngine.sharedInstance.cols = Int(stepper2.value)
        label2.text = String(Int(stepper2.value))
        backgroundChange = true
        StandardEngine.sharedInstance.grid = Grid(rows: StandardEngine.sharedInstance.rows, cols: StandardEngine.sharedInstance.cols)
    }
    
    @IBOutlet var label3: UILabel!
    @IBOutlet var slider: UISlider!
    @IBAction func sliderchanged(sender: UISlider)
    {
        StandardEngine.sharedInstance.refreshInterval = NSTimeInterval(slider.value)
        label3.text = String(Double(Int(slider.value*10))/10)
    }
    
    @IBOutlet var switchbutton: UISwitch!
    @IBAction func switchchanged(sender: UISwitch)
    {
        if switchbutton.on
        {
            StandardEngine.sharedInstance.refreshInterval = NSTimeInterval(slider.value)
        }
        else
        {
            StandardEngine.sharedInstance.refreshTimer?.invalidate()
        }
    }
    
    
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
        StandardEngine.sharedInstance.rows = StandardEngine.sharedInstance.rows
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
        StandardEngine.sharedInstance.rows = StandardEngine.sharedInstance.rows
    }
    
    @IBOutlet var rd: PushButtonViewR!
    @IBAction func redPushed(sender: AnyObject)
    {
        red = true
        orange = false
        green = false
        blue = false
        purple = false
        
        rd.setNeedsDisplay()
        or.setNeedsDisplay()
        gr.setNeedsDisplay()
        bl.setNeedsDisplay()
        pr.setNeedsDisplay()

        //just to send the notification
        backgroundChange = true
        StandardEngine.sharedInstance.rows = StandardEngine.sharedInstance.rows
    }

    
    @IBOutlet var or: PushButtonViewO!
    @IBAction func orangePushed(sender: UIButton)
    {
        red = false
        orange = true
        green = false
        blue = false
        purple = false
        
        rd.setNeedsDisplay()
        or.setNeedsDisplay()
        gr.setNeedsDisplay()
        bl.setNeedsDisplay()
        pr.setNeedsDisplay()
        
        //just to send the notification
        backgroundChange = true
        StandardEngine.sharedInstance.rows = StandardEngine.sharedInstance.rows
    }
    
    @IBOutlet var gr: PushButtonViewG!
    @IBAction func greenPushed(sender: UIButton)
    {
        red = false
        orange = false
        green = true
        blue = false
        purple = false
        
        rd.setNeedsDisplay()
        or.setNeedsDisplay()
        gr.setNeedsDisplay()
        bl.setNeedsDisplay()
        pr.setNeedsDisplay()
        
        //just to send the notification
        backgroundChange = true
        StandardEngine.sharedInstance.rows = StandardEngine.sharedInstance.rows
    }
    

    @IBOutlet var bl: PushButtonViewB!
    @IBAction func bluePressed(sender: UIButton)
    {
        red = false
        orange = false
        green = false
        blue = true
        purple = false
        
        rd.setNeedsDisplay()
        or.setNeedsDisplay()
        gr.setNeedsDisplay()
        bl.setNeedsDisplay()
        pr.setNeedsDisplay()
        
        //just to send the notification
        backgroundChange = true
        StandardEngine.sharedInstance.rows = StandardEngine.sharedInstance.rows
    }
    

    @IBOutlet var pr: PushButtonViewP!
    @IBAction func purplePressed(sender: UIButton)
    {
        print("pushed")
        red = false
        orange = false
        green = false
        blue = false
        purple = true
        
        rd.setNeedsDisplay()
        or.setNeedsDisplay()
        gr.setNeedsDisplay()
        bl.setNeedsDisplay()
        pr.setNeedsDisplay()
        
        //just to send the notification
        backgroundChange = true
        StandardEngine.sharedInstance.rows = StandardEngine.sharedInstance.rows
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

