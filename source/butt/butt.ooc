
// yada yada we need stuff
use dye, luajit

// no really tho we need stuff
import dye/[app]
import lua/howling/[Binding]

Butt: class extends App {

    lua: Binding

    init: func {
        super("Butt")
        lua := Binding new("butt.repo")
    }

    setup: func {
        "Shed me up" println()
    }

    update: func {
        "Naananana updateman" println()
    }

}

main: func {
    "Aw yiss butt." println()
    butt := Butt new()
    butt run(60.0f)
}
