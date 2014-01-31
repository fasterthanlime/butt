
// we just import a shitload of stuff here so it gets linked and
// then we can use it from lua

// 2D engine
use dye
import dye/[core, sprite, text, primitives]

// physics
use quantum
import quantum/[world, collisions, quadtree]

// .tmx loading
use tiled
import tiled/[Map, Layer, Tile, TileSet, Image, data, helpers]

