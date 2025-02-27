alias demo_stretch {

        var %c4  $calc(%dm.c /  4)
        var %c9  $calc(%dm.c /  9)
        var %c13 $calc(%dm.c / 13)
        var %c16 $calc(%dm.c / 16)

        ;; zoom
        var %zoom.x $calc(($sin(%c4).deg * 460) - %dm.stretch.zoom)
        var %zoom.y $calc(($sin(%c4).deg * 320) - %dm.stretch.zoom)

        ;; pan
        var %x1 $calc(($sin(%c9 ).deg * 96) + 480)
        var %y1 $calc(($cos(%c4 ).deg * 64) + 270)
        var %x2 $calc(($cos(%c13).deg * (($sin(%c9).deg * 160) + 160)) + 480)
        var %y2 $calc(($sin(%c16).deg * (($cos(%c9).deg *  90) +  90)) + 270)

        ;; stretch
        var %stretch.x $calc(($cos(%c4).deg * 96) + 48)
        var %stretch.y $calc(($sin(%c4).deg * 64) + 48)

        drawcopy -n @dm.stretch.tex $calc((%x1 + (%zoom.x / 2)) - (%stretch.x / 2)) $calc((%y1 + (%zoom.y / 2)) - (%stretch.y / 2)) $calc((320 - %zoom.x) + (%stretch.x * 2)) $calc((180 - %zoom.y) + %stretch.y) @demo  %dm.stretch.pan 0 320 180

        if (%dm.stretch.zoom > 200) {

                ddec dm.stretch.zoom 4
        }

        if (%dm.stretch.pan > 0) {

                ddec dm.stretch.pan .2
        }

        if (%dm.c > 10000) {

                var %y $gettok(%dm.stretch.fade.tab, %dm.stretch.fade.c, 32)

                drawline -nr @dm.stretch.1 0 1 0 %y 320 %y

                drawcopy -nt @dm.stretch.1 $rgb(255,255,255) 0 0 320 180 @demo 0 0 320 180

                dinc dm.stretch.fade.c .05

                if (%dm.stretch.fade.c > 180) {

                        set %dm.stretch.fade.c 180
                }

        }

        dmDrawFrame demo_stretch

        if (%dm.c > 14000) {

                .signal -n dmSelectPart vector
        }
}

alias tabel {

        var %cnt 1

        while (%cnt <= 180) {

                var %r $instok(%r, %cnt, $rand(1, $numtok(%r, 32)), 32)

                inc %cnt
        }

        echo -s %r
}