//
//  Problem4ViewController.swift
//  homework2_2nd
//
//  Created by Kiwook Kim on 7/3/16.
//  Copyright © 2016 sankim. All rights reserved.

import UIKit
import Foundation
class Problem4ViewController: UIViewController
{
    
    @IBOutlet var myText4: UITextView!
    @IBAction func myButton4(sender: UIButton)
    {
        var counter1:Int = 0;
        var before = [[Bool]]();
        
        for row in 0...9
        {
            before.append([Bool]())
            for _ in 0...9
            {
                if arc4random_uniform(3)==1
                {
                    before[row].append(true)
                    counter1+=1;
                }
                else
                {
                    before[row].append(false)
                }
            }
        }
        
        let myEngine4 = Engine()
        
        var final:[[Bool]] = myEngine4.step2(before)
        var counter2:Int = 0
        for row in 0...9
        {
            for col in 0...9
            {
                if final[row][col]==true
                {
                    counter2+=1;
                }
            }
        }
        
        myText4.text = "Before : \(counter1) —> After : \(counter2)"
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Problem 4"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}