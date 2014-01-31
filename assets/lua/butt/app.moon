
-- lua stuff
math = require 'math'
howling = require 'howling'

-- ooc stuff
dye_sprite = require 'dye:dye/sprite'
dye_text = require 'dye:dye/text'
dye_primitives = require 'dye:dye/primitives'
dye_input = require 'dye:dye/input'
io_File = require 'sdk:io/File'

-- util stuff
map = require 'butt.map'

-- Where the magic 'appens
class App
  new: (@butt) =>
    @dye = @butt.dye
    @input = @dye.input
    @frame = 0

    -- set dat clear color
    @dye.mainPass.clearColor\set__bang_ints(255, 255, 255)

    -- load a map maybe?
    @map = map.Map(@, "assets/maps/tuto1.tmx")
    @dye\add @map.group

    -- maek some text
    @text = dye_text.GlText.new 'assets/ttf/noodle.ttf', '', 40
    with @text.color
      .r = 255
      .g = 128
      .b = 50

    @textbg = dye_primitives.GlRectangle.new(@text.size)
    with @textbg.color
      .r = 0
      .g = 0
      .b = 0
    @textbg.center = false

    @dye\add @textbg
    @dye\add @text

    @offsetindex = 1
    
    onkp = (kp) ->
      @keyPress(kp.scancode)
    @input\onKeyPress_any howling.make_closure(onkp, "void", dye_input.KeyPress)

  keyPress: (scancode) =>
    switch scancode
      -- down
      when 81
        @offsetindex -= 1
      -- up
      when 82
        @offsetindex += 1

  clampOffsetIndex: =>
    if @offsetindex > @map.numLayers
      @offsetindex -= @map.numLayers
    elseif @offsetindex < 1
      @offsetindex += @map.numLayers

  focusLayer: =>
    for i = 1, tonumber(@map.numLayers)
      if @map.layers[i] == nil
        continue

      sprite = @map.layers[i].sprite

      with sprite
        if i == @offsetindex
          .opacity = 1.0
        else
          .opacity = 0.2

  update: =>
    -- count frames, yay
    @frame += 1

    @clampOffsetIndex()
    @focusLayer()

    if @map.layers[@offsetindex] == nil
      @text.value = "layer #{@offsetindex}"
    else
      @text.value = "layer #{@offsetindex}: #{@map.layers[@offsetindex].tlayer.name}"

    -- center text
    with @text.pos
      .x = 1280 / 2 - @text.size.x / 2
      .y = 40

    with @textbg.pos
      .x = @text.pos.x - 10
      .y = @text.pos.y - 10
    with @textbg.size
      .x = @text.size.x + 20
      .y = @text.size.y + 20

    -- update window title
    @dye\setTitle "bps = #{math.floor(@butt.loop.fps)}"

-- export da module
return {
  :App
}

