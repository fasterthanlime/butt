
-- fix that library stuff
local luaprefix = "./luaprefix"
package.path = package.path .. ";assets/lua/?.lua"
package.path = package.path .. ";" .. luaprefix .. "/share/lua/5.1/?/init.lua;" .. luaprefix .. "/share/lua/5.1/?.lua"
package.cpath = luaprefix .. "/lib/lua/5.1/?.so"

local butt = require("butt:butt/butt").Butt.getInstance()

require("moonscript")
local game = require("game")

local ctx = {}

function butt_update ()
    game.update(ctx, butt)
end

