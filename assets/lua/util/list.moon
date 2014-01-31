
-- lua stuff
ffi = require 'ffi'

get = (list, idx, typ) ->
    ptr = ffi.new(ffi.typeof("$*[1]", ffi.typeof(typ)))
    list\get(ffi.cast('uint8_t*', ptr), idx)
    ptr[0]

return {
  :get
}
