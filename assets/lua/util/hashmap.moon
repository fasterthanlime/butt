
-- lua stuff
ffi = require 'ffi'
howling = require 'howling'

get = (map, key, typ) ->
  -- prepare value
  valueptr = ffi.new(ffi.typeof("$*[1]", ffi.typeof(typ)))

  -- prepare key
  realkey = howling.to_ooc(key)
  keyptr = ffi.new(ffi.typeof("$*[1]", ffi.typeof(realkey)))
  keyptr[0] = ffi.cast('void*', realkey)

  -- call & dereference to get result
  map\get(ffi.cast('uint8_t*', valueptr), ffi.cast('uint8_t*', keyptr))
  value = valueptr[0]
  
  if value == nil
    return nil
  howling.from_ooc(value)

return {
  :get
}

