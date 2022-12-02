import Data.Bifunctor (second)
import Data.Char (isSpace)
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
score =
    sum . map (socreOfOne . second tail . break isSpace)

data Outcome = Win | Draw | Lose
    deriving (Eq)

data Play = Rock | Paper | Scissors
    deriving (Enum)

socreOfOne :: ([Char], [Char]) -> Int
socreOfOne (your, result) =
    let win = decode result
        played = findPlay (play your) win
     in valueOf played + case win of
            Win -> 6
            Draw -> 3
            Lose -> 0

findPlay :: Play -> Outcome -> Play
findPlay opp result =
    fromMaybe (error "invalid move") $ find (\mine -> outcome opp mine == result) $ enumFrom Rock

decode :: [Char] -> Outcome
decode "X" = Lose
decode "Y" = Draw
decode "Z" = Win
decode other = error $ "Unknown outcome " ++ other

outcome :: Play -> Play -> Outcome
outcome Rock Paper = Win
outcome Scissors Rock = Win
outcome Paper Scissors = Win
outcome Paper Rock = Lose
outcome Rock Scissors = Lose
outcome Scissors Paper = Lose
outcome _ _ = Draw

play :: [Char] -> Play
play "A" = Rock
play "B" = Paper
play "C" = Scissors
play "X" = Rock
play "Y" = Paper
play "Z" = Scissors
play play = error $ "unknown play " ++ play

valueOf :: Play -> Int
valueOf Rock = 1
valueOf Paper = 2
valueOf Scissors = 3
