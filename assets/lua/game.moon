
math = require 'math'
ffi = require 'ffi'
dye = {}
dye.sprite = require 'dye:dye/sprite'

game = {}

-- Set up things once and furall
game.setup = (ctx, butt) ->
    ctx.sprite = dye.sprite.GlSprite.new_fromPath "assets/png/itch.png"
    butt.dye\add ffi.cast('void*', ctx.sprite)

-- Update stuff once per frame
game.update = (ctx, butt) ->
    if ctx.frame == nil
        game.setup(ctx, butt)
        ctx.frame = 0
    else
        ctx.frame += 1

    -- update sprite pos
    with ctx.sprite
        .pos = butt.dye.input.mousepos

    -- update  window title
    butt.dye\setTitle "frame = #{ctx.frame}, fps = #{math.floor(butt.loop.fps)}"

return game
