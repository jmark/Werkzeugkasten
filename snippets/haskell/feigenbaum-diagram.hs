import Text.Printf

logistic :: Float -> Float -> Float
logistic r x = r*x*(1-x)

iterLogistic :: Float -> Float -> [Float]
iterLogistic x0 r = take (10*10^3) $ drop (5*10^3) $ iterate (logistic r) x0

main = mapM_ (\(r,x) -> putStrLn $ show r ++ " " ++ show x ) result
   where result = concat $ map (\r -> map (\x -> (r,x)) $ iterLogistic 0.1 r) $ takeWhile (<=4.0) $ iterate (+0.0005) 1.0
