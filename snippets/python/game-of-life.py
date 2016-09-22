#!/usr/bin/python

import numpy as np
import time

N = 48

world  = np.random.randint(0,2,N*N).reshape(N,N)
neighb = np.empty_like(world)

while (1):
    # count neighbours
    neighb = np.roll(world,-1,0)\
           + np.roll(world, 1,0)\
           + np.roll(world,-1,1)\
           + np.roll(world, 1,1)\
           + np.roll(np.roll(world,-1,0),-1,1)\
           + np.roll(np.roll(world,-1,0), 1,1)\
           + np.roll(np.roll(world, 1,0),-1,1)\
           + np.roll(np.roll(world, 1,0), 1,1)

    birth   =  (world==0) &  (neighb==3) 
    survive =  (world==1) & ((neighb==2) | (neighb==3))

    world[...] = 0
    world[birth | survive] = 1

    out = "\033[0;0H+"
    for row in world:
        out += '-'
    out += "+\n"

    for row in world:
        out += '|'
        for cell in row:
            out += "#" if cell else " "
        out += "|\n"

    out += "+"
    for row in world:
        out += '-'
    out += "+"

    time.sleep(0.1)
    print (out)
