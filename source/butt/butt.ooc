
// yada yada we need stuff
use dye, luajit

// no really tho we need stuff
import dye/[app]
import lua/howling/[Binding]

// awwwwwww link all dat shit
import butt/catchall

Butt: class extends App {

    // loofah
    lua: Binding

    init: func {
        instance = this
        super("Butt", 1280, 720)
    }

    setup: func {
        lua = Binding new("butt.repo")
        lua runFile("assets/lua/init.lua")
    }

    update: func {
        lua runString("butt_update()")
    }

    // shingleton
    instance: static This

    getInstance: static func -> This {
        instance
    }

}

main: func {
    "Aw yiss butt." println()
    butt := Butt new()
    butt run(60.0f)
}

