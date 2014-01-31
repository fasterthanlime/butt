
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

clean:
	rock -x
	rm -rf *.dSYM

win32:
	PATH=/usr/i686-w64-mingw32/bin:$(PATH) \
	PKG_CONFIG_PATH=/usr/i686-w64-mingw32/lib/pkgconfig \
	rock --host=i686-w64-mingw32 -L$(HOME)/Dev/dummyprefix-i686-w64-mingw32/lib -v

osx32:
	PATH=/usr/i686-apple-darwin11/usr/bin:$(PATH) \
	PKG_CONFIG_PATH=/usr/i686-apple-darwin11/usr/lib/pkgconfig \
	rock --host=i686-apple-darwin11 -L$(HOME)/Dev/dummyprefix-i686-apple-darwin11/lib --bannedflag=-fno-pie -v

spotless: clean lualibs-clean

