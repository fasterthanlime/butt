
-- ooc stuff
io_File = require 'sdk:io/File'
tiled_Map = require 'tiled:tiled/Map'
tiled_Layer = require 'tiled:tiled/Layer'
dye_core = require 'dye:dye/core'
dye_sprite = require 'dye:dye/sprite'

-- util stuff
list = require 'util.list'

class Map
  new: (@app, @path) =>
    file = io_File.File.new @path
    @tmap = tiled_Map.Map.new file
    print "map orientation = #{@tmap.orientation}"

    @tlayer = list.get(@tmap.mapLayers, 0, tiled_Layer.Layer)
    print "layer name = #{@tlayer.name}"

    @group = dye_core.GlGroup.new()

    for y = 0, tonumber(@tmap.height) - 1
      for x = 0, tonumber(@tmap.width) - 1
        index = x + (y * @tmap.width)
        lid = @tlayer.data[index]
        tile = @tmap\getTile(lid)
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

return {
  :Map
}
