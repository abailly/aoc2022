module Main where

import System.Environment (getArgs)
import System.Process (callCommand)

main :: IO ()
main = do
    [day, file] <- getArgs
    callCommand $ "stack runghc Day" <> day <> ".hs -- " <> file
