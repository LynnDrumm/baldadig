alias demo_copper {

        if (%dm.c > 1000) {

                if (%dm.copper.flash >= 1) {

                        set %dm.copper.flash.c 255
                        set %dm.copper.flash 0
                }

                dinc dm.copper.flash %dm.bpm
        }

        ddec dm.copper.flash.c 4

        if (%dm.copper.flash.c < 0) {

                set %dm.copper.flash.c 0
        }

        drawrect -nrf @demo $rgb(%dm.copper.flash.c, %dm.copper.flash.c, %dm.copper.flash.c) 0 0 0 320 180

        if (%dm.c > 12000) {

                dinc dm.copper.fadeout .1
        }

        drawpic -nct @demo $rgb(255,255,255) 18 $calc(63 - %dm.copper.fadeout) $qt($scriptdirimg\baldadig.png)

        ;; ugly code I ripped from party cannon which i ripped from an unfinished 2k, sorry :(
        var %bcount %dm.copper.barcount
        var %t 80,112,144,176,208,240,208,176,144,112,80
        var %a $!rgb(%k,0,0) $!rgb(%k,0,%k) $!rgb(0,0,%k) $!rgb(0,%k,%k) $!rgb(0,%k,0) $!rgb(%k,%k,0) $!rgb(%k,%k,%k) $!rgb(%k,%k,0) $!rgb(0,%k,0) $!rgb(0,%k,%k) $!rgb(0,0,%k) $!rgb(%k,0,%k) $!rgb(%k,0,0)
        var %b 1

        var %c $calc(%dm.c / 16)
        var %c4 $calc(%dm.c / 8)

        while (%b <= %bcount) {

                var %d $gettok(%a, %b, 32)
                var %y $calc(($cos($calc((%c * 2) + (%b * 8))).deg * (($sin(%c).deg * 64) + 32)) + %dm.copper.y.offset)
                var %e 1

                var %sin $calc($cos($calc(%c4 + (%b * 16))).deg * 16)

                while (%e <= 12) {

                        var %k $gettok(%t, %e, 44)
                        var %f $calc(%y + %e)

                        drawline -nr @demo $(%d,2) 2 -4 $calc(%f - %sin) 320 $calc(%f + %sin)

                        inc %e 2
                }

                inc %b
        }

        if (%dm.c < 8000) {

                if (%dm.copper.barcount <= 16) {

                        dinc dm.copper.barcount $calc(%dm.bpm * 4)
                }

                else {

                        set %dm.copper.barcount 16
                }

                if (%dm.copper.y.offset < 85) {

                        dinc dm.copper.y.offset .03
                }
        }

        if (%dm.c > 10500) {

                dinc dm.copper.y.offset .025
        }

        if (%dm.c > 14000) {

                .signal -n dmSelectPart starfield
                halt
        }


        dmDrawFrame demo_copper
}