
-- fix that library stuff
local ffi = require 'ffi'
print("ffi.os = " .. ffi.os)
print("ffi.arch = " .. ffi.arch)

local luaprefix = "./luaprefix"
local luaext = "so"
if ffi.os == "Windows" then
  luaext = "dll"
elseif ffi.os == "OSX" then
  luaext = "dylib"
end

package.path = package.path .. ";assets/lua/?.lua"
package.path = package.path .. ";" .. luaprefix .. "/share/lua/5.1/?/init.lua;" .. luaprefix .. "/share/lua/5.1/?.lua"
package.cpath = package.cpath .. ";" .. luaprefix .. "/lib/lua/5.1/?." .. luaext

-- moon > coffee
require("moonscript")

-- where it all begins
local app = require("butt.app")

-- global state is fun, right?
local butt = require("butt:butt/butt").Butt.getInstance()
local app = app.App(butt)

function butt_update ()
    app:update()
end

