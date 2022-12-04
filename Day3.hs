module Day3 where

import Data.Char (isLower)
import qualified Data.Set as Set

day3 :: String -> IO ()
day3 file = do
    input <- lines <$> readFile file
    print $ score2 input

score1 :: [String] -> Int
score1 = sum . map (priority . findDuplicate)

score2 :: [String] -> Int
score2 = sum . map (priority . findCommonChar) . groupBy3

findCommonChar :: [String] -> Char
findCommonChar = head . Set.toList . foldl1 Set.intersection . map Set.fromList

groupBy3 :: [String] -> [[String]]
groupBy3 [] = []
groupBy3 lns = first : groupBy3 rest
  where
    (first, rest) = splitAt 3 lns

priority :: Char -> Int
priority c
    | isLower c = fromEnum c - fromEnum 'a' + 1
    | otherwise = fromEnum c - fromEnum 'A' + 27

findDuplicate :: String -> Char
findDuplicate line =
    let len = length line
        (one, two) = splitAt (len `div` 2) line
     in findCommonChar [one, two]

findMatch :: [Char] -> [Char] -> Char
findMatch (x : xs) (y : ys) = case compare x y of
    LT -> findMatch xs (y : ys)
    GT -> findMatch (x : xs) ys
    EQ -> x
findMatch _ _ = error "no match found"
