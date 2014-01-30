
-- lua stuff
ffi = require 'ffi'
math = require 'math'

-- ooc stuff
dye_sprite = require 'dye:dye/sprite'
dye_text = require 'dye:dye/text'

-- our module
app = {}

-- Where the magic 'appens
class app.App
    new: (@butt) =>
        @dye = @butt.dye
        @input = @dye.input
        @frame = 0

        -- set dat clear color
        @dye.mainPass.clearColor\set__bang_ints(40, 15, 27)

        -- load a sprite and stuff
        @sprite = dye_sprite.GlSprite.new_fromPath "assets/png/itch.png"
        @dye\add ffi.cast('void*', @sprite)

        @text = dye_text.GlText.new "assets/ttf/noodle.ttf", "SPACE DONKEYS", 40
        with @text.color
            .r = 255
            .g = 128
            .b = 50
        with @text.pos
            .x = 800 / 2 - @text.size.x / 2
            .y = 40
        @dye\add ffi.cast('void*', @text)

    update: =>
        -- count frames, yay
        @frame += 1

        -- move dat sprite body
        @sprite.pos = @input.mousepos

        -- update window title
        @dye\setTitle "[PRESS SPACE] frame #{@frame}, fps = #{math.floor(@butt.loop.fps)}"

        @text.visible = @input\isPressed(44)

        if @text.visible
            @sprite.opacity = 0.5
        else
            @sprite.opacity = 1.0

-- export da module
return app

