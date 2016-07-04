//
//  Problem2ViewController.swift
//  homework2_2nd
//
//  Created by Kiwook Kim on 7/3/16.
//  Copyright © 2016 sankim. All rights reserved.
//
import UIKit
import Foundation
class Problem2ViewController: UIViewController
{
    @IBOutlet var myText: UITextView!
    @IBAction func myButton2(sender: UIButton)
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
        
        
        myText.text = "Before : \(counter1) —> "
        //print to the UITextView
        
        
        //make a grid that NULLIFIES the need to "wrap," by making the dimensions 1 larger on every side/corner: "before" is a 10x10 array, make "grid" 2-d array that is 12x12, with the 10x10 "before" being in the center, bordered by the corresponding "other sides," or what would have been if wrapped. That way, I can check the 10x10 "before" within the 12x12 "grid" normally (or as the "default:") WITHOUT the switch statement or out-of-bounds errors
        
        var grid = [[Bool]]()
        grid.append(before[9])
        grid[0].insert(before[9][9], atIndex: 0)
        grid[0].append(before[9][0])
        for row in 1...10
        {
            grid.append(before[row-1])
            grid[row].insert(before[row-1][9], atIndex: 0)
            grid[row].append(before[row-1][0])
        }
        grid.append(before[0])
        grid[11].insert(before[0][9], atIndex: 0)
        grid[11].append(before[0][0])
        
        
        
        var after = [[Bool]]()
        for row in 1...10
        {
            after.append([Bool]())
            for col in 1...10
            {
                after[row-1].append(grid[row][col])
            }
        }
        
        
        //check from 1...10 because indexes 0 and 12 for both row and col are the opposite, "wrapped sides" if they were there, that way you only have to check once without "switch"
        for row in 1...10
        {
            for col in 1...10
            {
                var counterA = 0
                var counterD = 0
                
                if grid[row-1][col-1]==true
                {if grid[row][col]==true {counterA += 1}
                    if grid[row][col]==false {counterD += 1}}
                if grid[row-1][col]==true
                {if grid[row][col]==true {counterA += 1}
                    if grid[row][col]==false {counterD += 1}}
                if grid[row-1][col+1]==true
                {if grid[row][col]==true {counterA += 1}
                    if grid[row][col]==false {counterD += 1}}
                if grid[row][col-1]==true
                {if grid[row][col]==true {counterA += 1}
                    if grid[row][col]==false {counterD += 1}}
                if grid[row][col+1]==true
                {if grid[row][col]==true {counterA += 1}
                    if grid[row][col]==false {counterD += 1}}
                if grid[row+1][col-1]==true
                {if grid[row][col]==true {counterA += 1}
                    if grid[row][col]==false {counterD += 1}}
                if grid[row+1][col]==true
                {if grid[row][col]==true {counterA += 1}
                    if grid[row][col]==false {counterD += 1}}
                if grid[row+1][col+1]==true
                {if grid[row][col]==true {counterA+=1}
                    if grid[row][col]==false {counterD += 1}}
                
                switch before
                {
                case _ where before[row-1][col-1]==false:
                    if counterD==3
                    {
                        after[row-1][col-1]=true
                    }
                    
                case _ where before[row-1][col-1]==true:
                    if counterA < 2 || counterA > 3
                    {
                        after[row-1][col-1]=false
                    }
                default:
                    after[row-1][col-1] = before[row-1][col-1]
                }
            }
        }
        
        
        var counter2:Int = 0
        for row in 0...9
        {
            for col in 0...9
            {
                if after[row][col]==true
                {
                    counter2+=1;
                }
            }
        }
        
        //PRINT to the UITextView
        myText.text = myText.text + "After : \(counter2)"

    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Problem 2"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}