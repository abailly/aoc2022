module Day4 where

import Data.Bifunctor (second)
import Data.Char (isLower, isSpace)
import Data.Either (fromRight)
import Data.Foldable (find)
import Data.List (groupBy, sort)
import Data.Maybe (fromMaybe, mapMaybe)
import qualified Data.Set as Set
import System.Environment (getArgs)
import Text.Parsec (char, runParser)
import Text.Parsec.Language (haskellDef)
import Text.Parsec.String (Parser)
import Text.Parsec.Token (integer)
import qualified Text.Parsec.Token as P

day4 :: String -> IO ()
day4 file = do
    input <- lines <$> readFile file
    print $ score1 input

score1 :: [String] -> Int
score1 = length . filter overlaps . map parse

overlaps :: (Interval, Interval) -> Bool
overlaps ((x1, y1), (x2, y2)) =
    (x1 >= x2 && x1 <= y2)
        || (y1 >= x2 && y1 <= y2)
        || (x2 >= x1 && x2 <= y1)
        || (y2 >= x1 && y2 <= y1)

type Interval = (Int, Int)

parse :: String -> (Interval, Interval)
parse s = case runParser parser () "" s of
    Left e -> error (show e)
    Right i -> i
  where
    lexer = P.makeTokenParser haskellDef

    integer = P.integer lexer

    parser :: Parser (Interval, Interval)
    parser = do
        p1 <- intervalParser
        char ','
        p2 <- intervalParser
        pure (p1, p2)

    intervalParser :: Parser Interval
    intervalParser = do
        i1 <- integer
        char '-'
        i2 <- integer
        pure (fromInteger i1, fromInteger i2)
