distr :: (Ord a,Num a) => [[a]] -> [a] -> [Int]
distr bins vs = map (\[l,r] -> length.filter (\v -> l<=v && v<r) $ vs) bins

binsEqDist :: (Ord a,Num a) => a -> a -> a -> [[a]]
binsEqDist min max step =
    tail $ takeWhile (\[_,r] -> r <= max) $ iterate (\[_,r] -> [r,r+step]) [0,min]
