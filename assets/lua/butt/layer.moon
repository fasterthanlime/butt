
-- ooc stuff
io_File = require 'sdk:io/File'
tiled_Map = require 'tiled:tiled/Map'
tiled_Layer = require 'tiled:tiled/Layer'
dye_core = require 'dye:dye/core'
dye_math = require 'dye:dye/math'
dye_sprite = require 'dye:dye/sprite'
dye_fbo = require 'dye:dye/gritty/fbo'

-- util stuff
list = require 'util.list'

class Layer
  @totalTiles: 0

  new: (@map, @tlayer) =>
    @tmap = @map.tmap
    @group = dye_core.GlGroup.new()

    @build!
    @cache!

  build: =>
    for y = 0, tonumber(@tmap.height) - 1
      for x = 0, tonumber(@tmap.width) - 1
        @buildTile(x, y)

  cache: =>
    fboSize = dye_math.Vec2i.new(1280, 704)
    @fbo = dye_fbo.Fbo.new(fboSize)

    -- 1 = RenderTarget TEXTURE
    @pass = dye_core.Pass.new(@map.app.dye, 1, @fbo)
    @pass.catchAll = true
    @pass.group = @group
    @pass.clears = false
    @pass\render!

    @sprite = dye_sprite.GlSprite.new_fromTex(@fbo.texture)
    @sprite.center = false

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

