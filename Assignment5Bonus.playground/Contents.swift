import UIKit


// self note : != acts as more or less the "XOr" function from boolean algebra

func isLeap(year:Int)->Bool
{
    return false != ((year%4 == 0) != ((year%100 == 0) != (year%400 == 0)))
}



let months = [31,28,31,30,31,30,31,31,30,31,30,31]
let monthsLeap = [31,29,31,30,31,30,31,31,30,31,30,31]

func julianDate(year:Int, month:Int, day:Int) -> Int
{
    var total = (1900..<year).reduce(0){return isLeap($1) ? $0+366:$0+365}
    total += (0..<month-1).reduce(0){return isLeap(year) ? $0+monthsLeap[$1]:$0+months[$1]}
    return total + day
}



julianDate(1960, month:  9, day: 28)
julianDate(1900, month:  1, day: 1)
julianDate(1900, month: 12, day: 31)
julianDate(1901, month: 1, day: 1)
julianDate(1901, month: 1, day: 1) - julianDate(1900, month: 1, day: 1)
julianDate(2001, month: 1, day: 1) - julianDate(2000, month: 1, day: 1)
isLeap(1960)
isLeap(1900)
isLeap(2000)
