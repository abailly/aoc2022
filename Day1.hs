module Day1 where

import Data.List (groupBy, sort)
import System.Environment (getArgs)

day1 :: String -> IO ()
day1 file = do
    input <- lines <$> readFile file
    print $ maximumElf input

maximumElf :: [String] -> Int
maximumElf =
    sum . take 3 . reverse . sort . map (sum . map read) . splitOnEmpty

splitOnEmpty :: [String] -> [[String]]
splitOnEmpty [] = []
splitOnEmpty items = first : splitOnEmpty (if null rest then rest else tail rest)
  where
    (first, rest) = break null items
