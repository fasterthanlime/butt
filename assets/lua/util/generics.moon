
-- lua stuff
ffi = require 'ffi'

ptr = (typ) ->
    -- yo friedrich, imma let you finish but I had one of the ugliest hacks of all time
    sname = string.gsub(string.gsub("#{typ}", "ctype<", ""), ">", "")
    return ffi.new("#{sname}*[1]")

return {
  :ptr
}

