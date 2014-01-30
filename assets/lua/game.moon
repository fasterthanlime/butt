
math = require 'math'

update = (ctx, butt) ->
    if ctx.count == nil
        ctx.count = 0
    else
        ctx.count += 1

    butt.dye\setTitle("count = #{ctx.count}, fps = #{math.floor(butt.loop.fps)}")

game_module =
    :update

return game_module
