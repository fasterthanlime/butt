
-- ooc stuff
io_File = require 'sdk:io/File'
tiled_Map = require 'tiled:tiled/Map'
tiled_Layer = require 'tiled:tiled/Layer'
dye_core = require 'dye:dye/core'
dye_sprite = require 'dye:dye/sprite'

-- util stuff
list = require 'util.list'
Layer = require('butt.layer').Layer

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

    print "Have #{Layer.totalTiles} total tiles"

return {
  :Map
}
