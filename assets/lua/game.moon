
math = require 'math'
ffi = require 'ffi'
dye = {}
dye.sprite = require 'dye:dye/sprite'

setup = (ctx, butt) ->
    ctx.sprite = dye.sprite.GlSprite.new_fromPath("assets/png/itch.png")
    butt.dye\add(ffi.cast('void*', ctx.sprite))

update = (ctx, butt) ->
    if ctx.frame == nil
        setup(ctx, butt)
        ctx.frame = 0
    else
        ctx.frame += 1

    with ctx.sprite
        .pos = butt.dye.input.mousepos

    butt.dye\setTitle("frame = #{ctx.frame}, fps = #{math.floor(butt.loop.fps)}")

game_module =
    :update

return game_module
