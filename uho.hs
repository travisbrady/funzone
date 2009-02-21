import Data.Array.Vector

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
    where folder = tripleSlot k

--test data
stuff :: UArr Int
stuff = toU [1,1,1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,7,8,8]

main = do
    let k = 4 :: Int
    let (lt, eq, gt) = (partition k stuff)::(UArr Int, UArr Int, UArr Int)
    print lt
    print eq
    print gt

