import Text.Printf

binsEqDist :: (Ord a,Num a) => a -> a -> a -> [[a]]
binsEqDist min max step =
    tail $ takeWhile (\[_,r] -> r <= max) $ iterate (\[_,r] -> [r,r+step]) [0,min]

distr :: Ord a => [[a]] -> [a] -> [Int]
distr bins vs = map (\[l,r] -> length.filter (\v -> l<=v && v<r) $ vs) bins

logistic :: Float -> Float -> Float
logistic r x = r*x*(1-x)

-- distLogistic :: Float -> [(Float,Float,Int)]
-- distLogistic r = map (\(b,n) -> (r,head b,toRGB n)) $ filter (\(b,n) -> n > 10) $
--     zip bins $ distr bins $ iterLogistic 0.1 r
--     where iterLogistic x0 r = take (5*10^3) $ drop (5*10^3) $ iterate (logistic r) x0
--           bins = binsEqDist 0 1 0.01
--           toRGB n = round $ 255*fromIntegral(n)/5000
--
-- main = mapM_ (\(r,b,c) -> putStrLn $ show r ++ " " ++ show b ++ " " ++ show c) result
--    where result = concat $ map distLogistic $ takeWhile (<=4.0) $ iterate (+0.02) 2.0

iterLogistic :: Float -> Float -> [Float]
iterLogistic x0 r = take (10*10^3) $ drop (5*10^3) $ iterate (logistic r) x0

main = mapM_ (\(r,x) -> putStrLn $ show r ++ " " ++ show x ) result
   where result = concat $ map (\r -> map (\x -> (r,x)) $ iterLogistic 0.1 r) $ takeWhile (<=4.0) $ iterate (+0.0005) 1.0
