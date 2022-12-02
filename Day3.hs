import Data.Bifunctor (second)
import Data.Char (isLower, isSpace)
import Data.Foldable (find)
import Data.List (groupBy, sort)
import Data.Maybe (fromMaybe)
import System.Environment (getArgs)

main :: IO ()
main = do
    [file] <- getArgs
    input <- lines <$> readFile file
    print $ score input

score :: [String] -> Int
score = sum . map (priority . findDuplicate)

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
