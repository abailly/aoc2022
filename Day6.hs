{-# LANGUAGE ViewPatterns #-}

module Day6 where

import Data.List (tails)
import Data.Set (fromList, size)

day6 :: String -> IO ()
day6 file = do
    input <- readFile file
    print $ score1 input

score1 :: String -> Int
score1 =
    (+ 14)
        . length
        . takeWhile ((< 14) . size)
        . map (fromList . take 14)
        . tails
