//
//  FirstViewController.swift
//  Assignment4
//
//  Created by Kiwook Kim on 7/12/16.
//  Copyright © 2016 sankim. All rights reserved.
//
//icons courtesy of Icon8


import UIKit

class InstrumentationViewController: UIViewController
{
    @IBOutlet var label1: UILabel!
    @IBOutlet var stepper1: UIStepper!
    @IBAction func stepper1changed(sender: UIStepper)
    {
        StandardEngine.sharedInstance.rows = Int(stepper1.value)
        label1.text = String(Int(stepper1.value))
        
        StandardEngine.sharedInstance.grid = Grid(rows: StandardEngine.sharedInstance.rows, cols: StandardEngine.sharedInstance.cols)
    }
    
    @IBOutlet var stepper2: UIStepper!
    @IBOutlet var label2: UILabel!
    @IBAction func stepper2changed(sender: UIStepper)
    {
        StandardEngine.sharedInstance.cols = Int(stepper2.value)
        label2.text = String(Int(stepper2.value))
        
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

