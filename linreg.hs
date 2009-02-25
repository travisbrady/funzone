--ghc -O2 -fvia-C -optc-O3 -funbox-strict-fields --make
--Pretty much a literal translation from the python 
--here http://www.answermysearches.com/how-to-do-a-simple-linear-regression-in-python/124/
module Main where

import Data.Array.Vector

regress :: UArr Double -> UArr Double -> (Double, Double)
regress x y = (a, b)
    where n = (fromIntegral $ lengthU x)::Double
          sx = sumU x
          sy = sumU y
          sxx = sumU $ mapU (**2) x
          syy = sumU $ mapU (**2) y
          sxy = sumU $ zipWithU (*) x y
          det = sxx * n - sx * sx
          a = (sxy * n - sy * sx)/det
          b = (sxx * sy - sx * sxy)/det

main = do
    let x = toU [1.0, 2.0, 3.0, 4.0]
    let y = toU [357.14,53.57,48.78,10.48]
    let (a,b) = regress x y
    print a
    print b
