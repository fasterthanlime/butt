
-- lua stuff
ffi = require 'ffi'
math = require 'math'

-- ooc stuff
dye_sprite = require 'dye:dye/sprite'

-- our module
app = {}

-- Where the magic 'appens
class app.App
    new: (@butt) =>
        @dye = @butt.dye
        @input = @dye.input
        @frame = 0

        -- load a sprite and stuff
        @sprite = dye_sprite.GlSprite.new_fromPath "assets/png/itch.png"
        @dye\add ffi.cast('void*', @sprite)

    update: =>
        -- count frames, yay
        @frame += 1

        -- move dat sprite body
        @sprite.pos = @input.mousepos

        -- update window title
        @dye\setTitle "frame #{@frame}, fps = #{math.floor(@butt.loop.fps)}"

-- export da module
return app

