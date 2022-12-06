{-# LANGUAGE ViewPatterns #-}

module Day5 where

import Common (groupByN)
import Data.Char (isSpace)
import Data.Functor (void)
import Data.List (foldl', transpose)
import Text.Parsec (runParser, space)
import Text.Parsec.Char (string)
import Text.Parsec.Language (haskellDef)
import Text.Parsec.String (Parser)
import qualified Text.Parsec.Token as P

day5 :: String -> IO ()
day5 file = do
    input <- lines <$> readFile file
    putStrLn $ score1 input

score1 :: [String] -> String
score1 inp =
    let (puzzleInput, movesInput) = break null inp
        puzzle = parsePuzzle puzzleInput
        moves = parseMoves $ tail movesInput
     in map head $ puzzle `apply` moves

apply :: Puzzle -> [Move] -> Puzzle
apply = foldl' applyMove

applyMove :: Puzzle -> Move -> Puzzle
applyMove puzzle (n, f, t) =
    let (src, rest) = splitAt n $ puzzle !! (f - 1)
        dest = src <> puzzle !! (t - 1)
        adjust (s, i)
            | i == f = rest
            | i == t = dest
            | otherwise = s
     in zipWith (curry adjust) puzzle [1 ..]

type Puzzle = [String]

parsePuzzle :: [String] -> Puzzle
parsePuzzle inp =
    let slices = map (equalise inp) inp
     in map (filter (not . isSpace)) $ transpose $ map parseCrates slices

parseCrates :: String -> String
parseCrates =
    concatMap toCrate . groupByN 4

toCrate :: String -> String
toCrate ('[' : l : ']' : _) = [l]
toCrate _ = " "

equalise :: [String] -> String -> String
equalise (maximum . map length -> maxLen) ln =
    let len = length ln
     in ln ++ replicate (maxLen - len) ' '

type Move = (Int, Int, Int)

parseMoves :: [String] -> [Move]
parseMoves = map parseMove

parseMove :: String -> Move
parseMove s =
    case runParser parser () "" s of
        Left e -> error (show e)
        Right i -> i
  where
    lexer = P.makeTokenParser haskellDef

    integer = P.integer lexer

    parser :: Parser Move
    parser = do
        void $ string "move" <* space
        n <- integer
        void $ string "from" <* space
        f <- integer
        void $ string "to" <* space
        t <- integer
        pure (fromIntegral n, fromIntegral f, fromIntegral t)
