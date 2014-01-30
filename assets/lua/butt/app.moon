
-- lua stuff
math = require 'math'

-- ooc stuff
dye_sprite = require 'dye:dye/sprite'
dye_text = require 'dye:dye/text'
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

        -- load a sprite and stuff
        @sprite = dye_sprite.GlSprite.new_fromPath 'assets/png/almightysuit.png'
        @sprite.center = false
        @sprite.opacity = 0.1
        @dye\add @sprite

        -- load a map maybe?
        @map = map.Map(@, "assets/maps/tuto1.tmx")
        @dye\add @map.group

        -- maek some text
        @text = dye_text.GlText.new 'assets/ttf/noodle.ttf', 'SPACE DONKEYS', 40
        with @text.color
            .r = 255
            .g = 128
            .b = 50
        with @text.pos
            .x = 1280 / 2 - @text.size.x / 2
            .y = 40
        @dye\add @text

    update: =>
        -- count frames, yay
        @frame += 1

        -- update window title
        @dye\setTitle "[PRESS SPACE] frame #{@frame}, fps = #{math.floor(@butt.loop.fps)}"

        @text.visible = @input\isPressed(44)
        @map.visible = not @text.visible

-- export da module
return {
  :App
}

