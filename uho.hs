module Main where
--Using uvector
--partition a vector
--compute median
import Data.Array.Vector
import System.Random

--Inserts el into either lt, eq or gt depending on the results of the compare with k
tripleSlot :: Int -> (UArr Int, UArr Int, UArr Int) -> Int -> (UArr Int, UArr Int, UArr Int)
tripleSlot k (lt, eq, gt) el = case el `compare` k of
    LT -> (consU el lt, eq, gt)
    EQ -> (lt, consU el eq, gt)
    GT -> (lt, eq, consU el gt)

empInt :: UArr Int
empInt = emptyU

--Break a UArr up into 3 chunks representing the elements
--that are LT, EQ, and GT
partition :: Int -> UArr Int -> (UArr Int, UArr Int, UArr Int)
partition k ua = foldlU folder (empInt, empInt, empInt) ua
    where 
        folder = tripleSlot k
        startTriple = (empInt, empInt, empInt)


select k s = do
    case (lengthU s) `compare` 1 of
        LT -> return Nothing
        EQ -> return $ Just (indexU s 0)
        GT -> do
            let len = lengthU s
            idx <- (randomRIO (0, len-1))::IO Int
            let a = indexU s idx
            let (lt, eq, gt) = partition a s
            let llt = lengthU lt
            if llt >= k
                then
                    select k lt
                else do
                    let leq = lengthU eq
                    if (llt + leq) >= k
                        then return $ Just a
                        else select (k - llt - leq) gt

findMedian ua = do
    let k = fst $ divMod (lengthU ua) 2
    med <- select k ua
    return med

--test data
stuff :: UArr Int
stuff = toU [1,1,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,7,8,8]

main = do
    let k = 4 :: Int
    let (lt, eq, gt) = (partition k stuff)::(UArr Int, UArr Int, UArr Int)
    print lt
    print eq
    print gt
    let a = (enumFromToU 1 200000)::UArr Int
    med <- findMedian a
    print med

