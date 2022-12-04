module Common where

groupByN :: Int -> [a] -> [[a]]
groupByN _ [] = []
groupByN n lns = first : groupByN n rest
  where
    (first, rest) = splitAt n lns
