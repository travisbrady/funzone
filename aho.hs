--Using pseudocode from http://ndevilla.free.fr/median/median/index.html
import System.Random
import Data.List ((!!))

gg _ [] tup = tup
gg el (x:xs) (lt,eq,gt)
    | x < el = gg el xs (x:lt, eq, gt)
    | x == el = gg el xs (lt, x:eq, gt)
    | otherwise = gg el xs (lt, eq, x:gt)

metal :: Int -> [Int] -> ([Int], [Int], [Int])
metal el xs = gg el xs ([], [], [])

select _ [] = return Nothing
select _ [el] = return $ Just el
select k s = do
    let len = length s
    idx::Int <- randomRIO (0, len-1)
    let a = s!!idx
    let (lt, eq, gt) = metal a s
    let llt = length lt
    if llt >= k 
        then
            select k lt
        else do
            let leq = length eq
            if (llt + leq) >= k
                then return $ Just a
                else select (k - llt - leq) gt
            
findMedian lst = do
    let k = fst $ divMod (length lst) 2
    med <- select k lst
    return med

main = do
    let a = [1..200000]::[Int]
    med <- findMedian a
    print med

