
-- ooc stuff
io_File = require 'sdk:io/File'
lang_String = require 'sdk:lang/String'
tiled_Map = require 'tiled:tiled/Map'
tiled_Layer = require 'tiled:tiled/Layer'
dye_core = require 'dye:dye/core'
dye_math = require 'dye:dye/math'
dye_sprite = require 'dye:dye/sprite'
dye_fbo = require 'dye:dye/gritty/fbo'
quantum_world = require 'quantum:quantum/world'

-- util stuff
list = require 'util.list'
hashmap = require 'util.hashmap'

class Layer
  @totalTiles: 0

  new: (@map, @tlayer) =>
    @tmap = @map.tmap
    @group = dye_core.GlGroup.new()

    @solid = hashmap.get(@tlayer.properties, "solid", lang_String.String)
    @build!
    @cache!

  build: =>
    for y = 0, tonumber(@tmap.height) - 1
      for x = 0, tonumber(@tmap.width) - 1
        @buildTile(x, y)

  cache: =>
    fboSize = dye_math.Vec2i.new(1280, 704)
    @fbo = dye_fbo.Fbo.new(fboSize)

    @pass = dye_core.Pass.new(@map.app.dye, dye_core.RenderTarget.TEXTURE, @fbo)
    @pass.catchAll = true
    @pass.group = @group
    @pass\render!

    @sprite = dye_sprite.GlSprite.new_fromTex(@fbo.texture)
    @sprite.center = false
    with @sprite.color
      .r = 230
      .g = 100
      .b = 105

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

    sprite = dye_sprite.GlGridSprite.new relpath, xnum, ynum
    with sprite
      .center = false
      .x = position.x / tileSet.tileWidth
      .y = position.y / tileSet.tileHeight
    with sprite.pos
      .x = x * tileSet.tileWidth
      .y = (@tmap.height - 1 - y) * tileSet.tileHeight

    @group\add sprite

    if @solid
      -- create geometry
      box = quantum_world.AABBShape.new(32, 32)
      box.inert = true
      with box.pos
        .x = sprite.pos.x + 16
        .y = sprite.pos.y + 16
      @map.app.world\addShape box

return {
  :Layer
}

