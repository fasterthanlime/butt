
-- lua stuff
math = require 'math'
howling = require 'howling'

-- ooc stuff
dye_sprite = require 'dye:dye/sprite'
dye_text = require 'dye:dye/text'
dye_primitives = require 'dye:dye/primitives'
dye_input = require 'dye:dye/input'
quantum_world = require 'quantum:quantum/world'
io_File = require 'sdk:io/File'

-- util stuff
map = require 'butt.map'

-- Where the magic 'appens
class App
  new: (@butt) =>
    @dye = @butt.dye
    @world = quantum_world.World.new()
    @world.gravity = -1.1
    @world.maxFallVel = -6

    @input = @dye.input
    @frame = 0

    -- set dat clear color
    @dye.mainPass.clearColor\set__bang(255, 255, 255)

    -- load a map maybe?
    @map = map.Map(@, "assets/maps/tuto1.tmx")
    @dye\add @map.group

    -- PHYSX TEST STARTS
    shape = quantum_world.AABBShape.new(32, 64)
    @body = quantum_world.Body.new(shape)
    @world\addBody @body

    @hero = dye_sprite.GlSprite.new("assets/png/hero-idle.png")
    @hero.pos = @body.pos
    @hero.pos\set__bang(600, 400)
    @dye\add @hero
    -- PHYSX TEST ENDS

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

    @offsetindex = 0
    
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
      -- left
      when 80
        return
      -- right
      when 79
        return
      -- space
      when 44
        @body.vel.y = 16
      else
        print "Unknown scancode: #{scancode}"

  clampOffsetIndex: =>
    if @offsetindex > @map.numLayers
      @offsetindex -= @map.numLayers + 1
    elseif @offsetindex < 0
      @offsetindex += @map.numLayers + 1

  focusLayer: =>
    for i = 1, tonumber(@map.numLayers)
      if @map.layers[i] == nil
        continue

      sprite = @map.layers[i].sprite

      with sprite
        if @offsetindex == 0 or i == @offsetindex
          .opacity = 1.0
        else
          .opacity = 0.2

  update: =>
    -- count frames, yay
    @frame += 1

    -- update physics
    delta = 0.33
    for i = 1,3
      @world\collide(delta)
      @world\step(delta)

    ---- key input
    if @input\isPressed(80)
      -- left
      @hero.scale.x = -1
      @body.vel.x = -5
    elseif @input\isPressed(79)
      -- right
      @hero.scale.x = 1
      @body.vel.x = 5
    else
      @body.vel.x *= 0.85

    @clampOffsetIndex()
    @focusLayer()

    if @offsetindex == 0
      @text.value = "all layers"
    else if @map.layers[@offsetindex] == nil
      @text.value = "layer #{@offsetindex}"
    else
      layer = @map.layers[@offsetindex]
      @text.value = "layer #{@offsetindex}: #{layer.tlayer.name}"
      if layer.solid
        @text.value = "#{@text.value} - solid"

    @text.value = "#{@text.value} - pos #{@body.pos\toString!} - vel #{@body.vel\toString!}"

    -- center text
    with @text.pos
      -- .x = 1280 / 2 - @text.size.x / 2
      .x = 200
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

