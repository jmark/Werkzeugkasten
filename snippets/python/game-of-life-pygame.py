#!/usr/bin/env python2

import sys
import pygame as pg
import numpy as np

BLACK = [ 0, 0, 0]
WHITE = [255, 255, 255]

N = 256
W = 4 
SIZE = [N*W, N*W]
TICK = 10000

P_CELL = 0.1
if len(sys.argv) > 1:
    P_CELL = float(sys.argv[1])

def create_world():
    world = np.zeros((N,N),dtype=np.uint8)
    x = y = 3*N//8
    X = Y = 3*N//8+N//4
    world[x:X,y:Y] = np.random.choice([0,1],(N//4,N//4),p=[1-P_CELL,P_CELL]).astype(np.uint8)
    return world

world = create_world()
neighb = np.empty_like(world,dtype=np.uint8)

pg.init()
screen = pg.display.set_mode(SIZE)
pg.display.set_caption("Conway's Game of Life")
#clock = pg.time.Clock()

done = False
iterate = False 

while not done:
    for event in pg.event.get():
        if event.type == pg.QUIT:
            done = True
        if (event.type == pg.KEYUP):
            if (event.key == pg.K_ESCAPE):
                done = True
            if (event.key == pg.K_r):
                world = create_world()
            if (event.key == pg.K_SPACE):
                iterate = not iterate


    if iterate:
        # count neighbours
        neighb = np.roll(world,-1,0)\
               + np.roll(world, 1,0)\
               + np.roll(world,-1,1)\
               + np.roll(world, 1,1)\
               + np.roll(np.roll(world,-1,0),-1,1)\
               + np.roll(np.roll(world,-1,0), 1,1)\
               + np.roll(np.roll(world, 1,0),-1,1)\
               + np.roll(np.roll(world, 1,0), 1,1)

        birth   = (world==0) &  (neighb==3) 
        survive = (world==1) & ((neighb==2) | (neighb==3))

        world[:] = 0
        world[birth | survive] = 1

    screen.fill(BLACK)

    for cell in np.argwhere(world):
        pg.draw.rect(screen, WHITE, (cell[0]*W,cell[1]*W, W, W), 0)

    pg.display.flip()
    #clock.tick(TICK)

pg.quit ()
