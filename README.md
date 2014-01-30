## butt

So ooc has this graphics framework, dye, right? And it's cool and high-level and stuff.

And lua is pretty cool to script, right? Except it's better to write moonscript.

And lua is easy to embed right? Except the ffi is slow when doing `C->Lua`, so we want
most of the game logic to run in lua, right?

So that's mostly what butt is about testing.

### Authors

  * Not me, I swear

### How to build

Run `make`, launch `./butt`. What do you mean you don't have all the dependencies?

  * Get rock 99x's branch working and in your path
  * Get clang or change the Makefile
  * Install luajit 2.0.1
  * Install luarocks
  * Do `make lualibs` - that should install moonscript in there
  * Get sam and do `sam get`, or clone ooc-lua & dye & the rest yourself in `$OOC_LIBS`

What do you mean those instructions aren't newcomer-friendly? Well they're not supposed to be!
  
### Links

  * ooc language: <http://ooc-lang.org>
  * ooc compiler: <https://github.com/nddrylliog/rock>
  * lua's coffeescript: <http://moonscript.org>
  * preferred lua impl: <http://luajit.org/>

Moar:

  * luarocks (lua package installer): <http://luarocks.org/>
  * sam (ooc package installer): <https://github.com/nddrylliog/sam>
  * dye 2D framework: <https://github.com/nddrylliog/dye>
  * ooc <-> lua bridge: <https://github.com/fredreichbier/ooc-lua>
  * ooc tiled map loader: <https://github.com/fredreichbier/ooc-tiled>

### License

MIT

