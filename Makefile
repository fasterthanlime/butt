
# C compile flags
DEBUG_FLAGS+=-pg -O0 +-w --cc=clang

LUAPREFIX:=$(PWD)/luaprefix

devbuild: lualibs
	rock -v $(DEBUG_FLAGS)

lualibs: luaprefix/share/lua/5.1/moonscript/init.lua

luaprefix/share/lua/5.1/moonscript/init.lua:
	luarocks install --tree=$(LUAPREFIX) moonscript

lualibs-clean:
	rm -rf $(LUAPREFIX)

clean: lualibs-clean
	rock -x
	rm -rf *.dSYM

