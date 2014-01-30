
-- lua stuff
ffi = require 'ffi'

generics = require 'util.generics'

list = {}

list.get = (list, idx, typ) ->
    ptr = generics.ptr(typ)
    list\get(ffi.cast('uint8_t*', ptr), idx)
    ptr[0]

return list
