alias demo_moire {

        drawrect -nrf @demo %dm.moire.k1 0 0 0 320 180

        var %x1 $calc(($cos($calc(%dm.moire.c / 4.2)).deg * 96) + 160)
        var %y1 $calc(($sin($calc(%dm.moire.c / 3.3)).deg * 64) + 90)
        var %x2 $calc(($sin($calc(%dm.moire.c / 4.9)).deg * 96) + 160)
        var %y2 $calc(($cos($calc(%dm.moire.c / 3.4)).deg * 64) + 90)

        var %s 12

        var %cnt 1

        while (%cnt <= %dm.moire.tot) {

                drawdot -nri @demo 0 $calc(%s * %cnt) %x1 %y1 %x2 %y2

                inc %cnt
        }

        if (%dm.moire.tot < 24) {

                dinc dm.moire.tot .05
        }

        drawpic -nct @demo $rgb(255,0,255) 0 32 0 0 320 %dm.moire.pic.h $qt($scriptdirimg\pblogo-t.png)

        if (%dm.c > 1000) {

                dinc dm.moire.c 1

                dinc dm.moire.k.c %dm.bpm

                if (%dm.moire.k.c >= 1) {

                        set %dm.moire.k1 $rgb($rand(0, 255), $rand(0, 255), $rand(0, 255))
                        set %dm.moire.k2

                        set %dm.moire.k.c 0
                }
        }

        else {

                if (%dm.moire.pic.h < 145) {

                        dinc dm.moire.pic.h .14
                }

                if (%dm.moire.pic.h > 145) {

                        set %dm.moire.pic.h 145
                }
        }

        if (%dm.c > 12000) {

                drawrect -nrf @demo 0 0 %dm.moire.fadeout 0 328 180

                if (%dm.moire.fadeout > 0) {

                        ddec dm.moire.fadeout .3
                }
        }

        dmDrawFrame demo_moire

        if (%dm.c > 13000) {

                .signal -n dmSelectPart stretch
                halt
        }
}