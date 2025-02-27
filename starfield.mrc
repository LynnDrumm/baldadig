alias demo_starfield {

        if (%dm.c < 5000) {

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

        if (%dm.c < 19000) {

                var %r $rand(0, 85)

                drawdot -nr @dm.starfield.1 $rgb($calc(%r / 2),$calc(%r / 2),%r) 1 $rand(321, 337) $rand(0, 180)
        }

        drawcopy -n @dm.starfield.1 0 0 340 180 @dm.starfield.1 $+(-,$calc((%dm.frt * 1.9) / 16)) 0 340 180

        drawcopy -nt @dm.starfield.1 0 0 0 320 180 @demo 0 0 320 180

        if (%dm.c > 2000) {

                if (%dm.c < 19000) {

                        var %r $rand(85, 170)

                        drawdot -nr @dm.starfield.2 $rgb($calc(%r / 2),%r,%r) 1 $rand(321, 336) $rand(0, 180)
                }

                drawcopy -n @dm.starfield.2 0 0 340 180 @dm.starfield.2 $+(-,$calc((%dm.frt * 2) / 16)) 0 340 180

                drawcopy -nt @dm.starfield.2 0 0 0 320 180 @demo 0 0 320 180
        }

        if (%dm.c > 4000) {

                if (%dm.c < 19000) {

                        var %r $rand(170, 255)

                        drawdot -nr @dm.starfield.3 $rgb(%r,%r,%r) $rand(1, $rand(1, $rand(1,2))) $rand(321, 336) $rand(0, 180)
                }

                drawcopy -n @dm.starfield.3 0 0 340 180 @dm.starfield.3 $+(-,$calc((%dm.frt * 2.6) / 16)) 0 340 180

                drawcopy -nt @dm.starfield.3 0 0 0 320 180 @demo 0 0 320 180
        }

        if (%dm.c > 6700) {

                var %c/6 $calc(%dm.c / 3)

                var %cnt        %dm.sinescroll.offset
                var %tot        $len(%dm.sinescroll.text)

                while (%cnt <= %tot) {

                        var %x $calc(%dm.sinescroll.x + (%cnt * 18))

                        if (%x > -16) {

                                if (%x < 320) {

                                        var %chr $right($left(%dm.sinescroll.text, %cnt), 1)

                                        if ($asc(%chr) != 32) {

                                                var %y $calc(($cos($calc(%c/6 + (%cnt * 8))).deg * 64) + 78)

                                                drawtext -nro @demo $gettok(%dm.sinescroll.ctab, $calc(%y / 1.2), 32) consolas 24 %x %y %chr
                                        }
                                }

                                else {
                                        break
                                }
                        }

                        else {

                                inc %dm.sinescroll.offset
                        }

                        inc %cnt
                }

                ddec dm.sinescroll.x .4
        }

        if (%dm.c > 22800) {

                .signal -n dmSelectPart rotozoom
                halt
        }

        dmDrawFrame demo_starfield
}