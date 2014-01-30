
-- ooc stuff
io_File = require 'sdk:io/File'
tiled_Map = require 'tiled:tiled/Map'
tiled_Layer = require 'tiled:tiled/Layer'
dye_core = require 'dye:dye/core'
dye_sprite = require 'dye:dye/sprite'

-- util stuff
list = require 'util.list'

class Layer
  new: (@map, @tlayer) =>
    print "tlayer = #{@tlayer.class.name}"
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

    tileSet = tile.tileSet
    image = tileSet.image
    source = image.source
    position = tile\getPosition!

    relpath = @tmap\relativePath source
    xnum = tileSet.tilesPerRow
    ynum = tileSet.tilesPerColumn

    sprite = dye_sprite.GlGridSprite.new_fromPath relpath, xnum, ynum
    with sprite
      .x = position.x / tileSet.tileWidth
      .y = position.y / tileSet.tileHeight
    with sprite.pos
      .x = x * tileSet.tileWidth
      .y = (@tmap.height - 1 - y) * tileSet.tileHeight

    @group\add sprite

class Map
  new: (@app, @path) =>
    file = io_File.File.new @path
    @tmap = tiled_Map.Map.new file
    print "map orientation = #{@tmap.orientation}"

    @group = dye_core.GlGroup.new()

    @layers = {}

    numLayers = @tmap.mapLayers.size
    for i = 0, tonumber(numLayers) - 1
      tlayer = list.get(@tmap.mapLayers, i, tiled_Layer.Layer)
      if tlayer.class.name != "Layer"
        print "Skipping layer of type #{tlayer.class.name}"
        continue

      print "Loading layer #{tlayer.name}"

      layer = Layer(@, tlayer)
      @layers[i] = layer
      @group\add layer.group

return {
  :Map
}
