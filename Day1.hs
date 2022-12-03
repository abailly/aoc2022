import Data.List (groupBy, sort)
import System.Environment (getArgs)

main :: IO ()
main = do
    [file] <- getArgs
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
