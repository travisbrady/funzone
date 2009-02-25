--ghc -O2 -fvia-C -optc-O3 -funbox-strict-fields --make
--Pretty much a literal translation from the python 
--here http://www.answermysearches.com/how-to-do-a-simple-linear-regression-in-python/124/
module Linreg where

import Data.Array.Vector
import Math.Statistics.Fusion

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

covariance x y = divN . sumU $ zipWithU (*)
                  (zipWithU (-) x (replicateU n mean_x))
                  (zipWithU (-) y (replicateU n mean_y))
                where
                    n = lengthU x
                    divN thing = thing/(fromIntegral n)
                    mean_x = mean x
                    mean_y = mean y

testX :: UArr Double
testX = toU [1.0, 2.0, 3.0, 4.0]
testY :: UArr Double
testY = toU [5.0, 10.0, 15.0, 20.0]

--main = do
--    let x = toU [1.0, 2.0, 3.0, 4.0]
--    let y = toU [357.14,53.57,48.78,10.48]
--    let (a,b) = regress x y
--    print a
--    print b
