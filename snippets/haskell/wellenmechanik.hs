import Text.Printf

xy :: (Ord a,Num a) => a -> a -> a -> [[a]]
xy min max step = [[x,y] | x <- axis, y <- axis]
                    where axis = takeWhile (<=max) $ iterate (+step) min

plainwave :: Float -> Float -> Float
plainwave x y = cos(x*8)

radialwave :: Float -> Float -> Float
radialwave x y = cos(sqrt(x*x+y*y)*10)

out [x,y,f] = printf "%f %f %f\n" x y f

main = do
    mapM_ out $ map (\[x,y] -> [x,y,plainwave x y + radialwave x y]) $ xy (-20) 20 0.1
