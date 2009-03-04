module Main where

import Data.List ((!!), foldl', sortBy)
import Data.Maybe (catMaybes)
import qualified Data.Map as M
import qualified Data.ByteString.Char8 as B
import Text.Regex.PCRE.Light
import Data.ByteString.Search.BoyerMoore
import Data.Function (on)

get = B.pack "GET /ongoing/When"

ssPred s = case (matchSS get s) of
    [] -> False
    _  -> True

main = do
    let p = compile (B.pack "GET /ongoing/When/\\d\\d\\dx/(\\d\\d\\d\\d/\\d\\d/\\d\\d/[^ .]+) ") []
    c <- B.readFile "o1000k.ap"
    let possibleMatches = filter (B.isInfixOf get) $ B.lines c
    --let possibleMatches = filter ssPred lines
    let matches = catMaybes $ map (\line -> match p line []) possibleMatches 
    let pnames = map (\x -> x!!1) matches
    let freqFold = foldl' g M.empty pnames 
                    where g accum k = M.insertWith' (+) k 1 accum
    let ll = sortBy (flip compare `on` snd) $ M.toList freqFold
    mapM_ print $ take 10 ll

