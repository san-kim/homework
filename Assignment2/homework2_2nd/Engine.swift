//
//  Engine.swift
//  homework2_2nd
//
//  Created by Kiwook Kim on 7/3/16.
//  Copyright © 2016 sankim. All rights reserved.
//
import Foundation

class Engine
{
    func step (before:[[Bool]]) -> [[Bool]]
    {
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
        
        return after
    }
    
    
    //coordinates accepted: between (0,0) and (9,9)
    func neighbors (row:Int, _ col:Int) -> [(Int,Int)]
    {
        var arr = [(Int,Int)]()
        //for the purpose of the "grid" being 12x12 to accomodate a 10x10 "before", add 1 to each row and col
        arr.append((row,col))
        arr.append((row,col+1))
        arr.append((row,col+2))
        arr.append((row+1,col))
        arr.append((row+1,col+2))
        arr.append((row+2,col))
        arr.append((row+2,col+1))
        arr.append((row+2,col+2))
        return arr
    }
    
    
    
    func step2 (before:[[Bool]]) -> [[Bool]]
    {
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
                
                
                var nbs = neighbors(row-1, col-1)
                for index in 0...7
                {
                    if grid[nbs[index].0][nbs[index].1] == true
                    {
                        if grid[row][col] == true
                        {
                            counterA += 1
                        }
                        else if grid[row][col] == false
                        {
                            counterD += 1
                        }
                    }
                }
                
                
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
        
        return after
    }
    
}