module Main where

import Day1 (day1)
import Day2 (day2)
import Day3 (day3)
import Day4 (day4)
import Day5 (day5)
import Day6 (day6)
import System.Environment (getArgs)

main :: IO ()
main = do
    [day, file] <- getArgs
    case (read day :: Int) of
        1 -> day1 file
        2 -> day2 file
        3 -> day3 file
        4 -> day4 file
        5 -> day5 file
        6 -> day6 file
        _other -> error "wrong day"
