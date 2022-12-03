import Data.Bifunctor (second)
import Data.Char (isLower, isSpace)
import Data.Foldable (find)
import Data.List (groupBy, sort)
import Data.Maybe (fromMaybe)
import qualified Data.Set as Set
import System.Environment (getArgs)

main :: IO ()
main = do
    [file] <- getArgs
    input <- lines <$> readFile file
    print $ score2 input

score1 :: [String] -> Int
score1 = sum . map (priority . findDuplicate)

score2 :: [String] -> Int
score2 = sum . map (priority . findTriplicate) . groupBy3

findTriplicate :: [String] -> Char
findTriplicate = head . Set.toList . foldl1 Set.intersection . map Set.fromList

groupBy3 :: [String] -> [[String]]
groupBy3 [] = []
groupBy3 lines = first : groupBy3 rest
  where
    (first, rest) = splitAt 3 lines

priority :: Char -> Int
priority c
    | isLower c = fromEnum c - fromEnum 'a' + 1
    | otherwise = fromEnum c - fromEnum 'A' + 27

findDuplicate :: String -> Char
findDuplicate line =
    let len = length line
        (one, two) = splitAt (len `div` 2) line
     in findMatch (sort one) (sort two)

findMatch :: [Char] -> [Char] -> Char
findMatch (x : xs) (y : ys) = case compare x y of
    LT -> findMatch xs (y : ys)
    GT -> findMatch (x : xs) ys
    EQ -> x
findMatch _ _ = error "no match found"
