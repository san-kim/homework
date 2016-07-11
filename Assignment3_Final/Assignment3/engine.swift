import Foundation

class engine
{
    func neighbors (row:Int, _ col:Int) -> [(Int,Int)]
    {
        var arr = [(Int,Int)]()
        arr.append((row+1,col+1))
        arr.append((row+1,col))
        arr.append((row+1,col-1))
        arr.append((row,col-1))
        arr.append((row,col+1))
        arr.append((row-1,col-1))
        arr.append((row-1,col))
        arr.append((row-1,col+1))
        return arr
    }
    
    
    
    func step (before:[[CellState]]) -> [[CellState]]
    {
        
        var after = [[CellState]]()
        for row in 0..<before.count
        {
            after.append([CellState]())
            for col in 0..<before[row].count
            {
                after[row].append(before[row][col])
            }
        }
        

        for row in 0..<before.count
        {
            for col in 0..<before[row].count
            {
                var counterA = 0
                var counterD = 0
                let H = before.count
                let W = before[row].count
                
                //the modulas does the "wrapping," the +10 assures that no negative values are passed
                
                var nbs = neighbors(row, col)
                for index in 0..<8
                {
                    if before[(nbs[index].0+H)%H][(nbs[index].1+W)%W] == .Living || before[(nbs[index].0+H)%H][(nbs[index].1+W)%W] == .Born
                    {
                        if before[row][col] == .Living || before[row][col] == .Born
                        {
                            counterA += 1
                        }
                        else if before[row][col] == .Died || before[row][col] == .Empty
                        {
                            counterD += 1
                        }
                    }
                }
                
                
                switch before
                {
                case _ where before[row][col] == .Died || before[row][col] == .Empty :
                    if counterD==3
                    {
                        after[row][col] = .Born
                    }
                    
                case _ where before[row][col] == .Living || before[row][col] == .Born :
                    if counterA < 2 || counterA > 3
                    {
                        after[row][col] = .Died
                    }
                default:
                    after[row][col] = before[row][col]
                }
            }
        }
        
        for r in 0..<before.count
        {
            for c in 0..<before[r].count
            {
                if before[r][c] == .Died && after[r][c] == .Died
                {
                    after[r][c] = .Empty
                }
                
                if before[r][c] == .Born && after[r][c] == .Born
                {
                    after[r][c] = .Living
                }
            }
        }
        
        return after
    }
    
}
