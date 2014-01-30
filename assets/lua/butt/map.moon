
-- ooc stuff
io_File = require 'sdk:io/File'
tiled_Map = require 'tiled:tiled/Map'
tiled_Layer = require 'tiled:tiled/Layer'

-- util stuff
list = require 'util.list'

class Map
  new: (@app, @path) =>
    file = io_File.File.new @path
    @tmap = tiled_Map.Map.new file
    print "map orientation = #{@tmap.orientation}"

    @tlayer = list.get(@tmap.mapLayers, 0, tiled_Layer.Layer)
    print "layer name = #{@tlayer.name}"

return {
  :Map
}
