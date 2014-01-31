
-- ooc stuff
io_File = require 'sdk:io/File'
tiled_Map = require 'tiled:tiled/Map'
tiled_Layer = require 'tiled:tiled/Layer'
dye_core = require 'dye:dye/core'
dye_sprite = require 'dye:dye/sprite'

-- util stuff
list = require 'util.list'

class Layer
  @totalTiles: 0

  new: (@map, @tlayer) =>
    @tmap = @map.tmap
    @group = dye_core.GlGroup.new()
    @build!

  build: =>
    for y = 0, tonumber(@tmap.height) - 1
      for x = 0, tonumber(@tmap.width) - 1
        @buildTile(x, y)

  getTile: (x, y) =>
    index = x + (y * @tmap.width)
    lid = @tlayer.data[index]
    @tmap\getTile(lid)

  buildTile: (x, y) =>
    tile = @getTile(x, y)
    if tile == nil
      -- skip empty tiles
      return

    @@totalTiles += 1

    tileSet = tile.tileSet
    image = tileSet.image
    source = image.source
    position = tile\getPosition!

    relpath = @tmap\relativePath source
    xnum = tileSet.tilesPerRow
    ynum = tileSet.tilesPerColumn

    sprite = dye_sprite.GlGridSprite.new_fromPath relpath, xnum, ynum
    with sprite
      .center = false
      .x = position.x / tileSet.tileWidth
      .y = position.y / tileSet.tileHeight
    with sprite.pos
      .x = x * tileSet.tileWidth
      .y = (@tmap.height - 1 - y) * tileSet.tileHeight

    @group\add sprite

return {
  :Layer
}

